USE [DW_DEV]
GO
/****** Object:  StoredProcedure [etl].[rebuild_stg_customer]    Script Date: 25/03/2026 16:07:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [etl].[rebuild_stg_customer]
AS
BEGIN
    SET NOCOUNT ON;

    TRUNCATE TABLE stg.customer;

    INSERT INTO stg.customer (
        [Customer No],
        [Customer Name],
        [Customer Class],
        [Salesman ID],
        [Branch ID],
        Divisi,
        [Sub.Div],
        [Credit Limit],
        Created,
        ACTIVE,
        Address,
        load_ts        
    )

        
SELECT 
       C.CUSTNMBR AS [Customer No], 
       C.CUSTNAME AS [Customer Name], 
       C.CUSTCLAS AS [Customer Class], 
       C.SLPRSNID AS [Salesman ID], 
       C.SALSTERR AS [Branch ID], 
       CASE 
            WHEN (charindex('@', rtrim(replace(ISNULL(CAST(TXTFIELD AS NVarchar(100)), ''), '|', '@'))) > 0) 
                  THEN LEFT(ltrim(replace(CAST(N.TXTFIELD AS NVarchar(100)), '|', ' ')), charindex(' ', ltrim(replace(isnull(CAST(N.TXTFIELD AS NVarchar(100)), ''), '|', ' '))) - 1) 
            ELSE isnull(N.TXTFIELD, '') 
       END AS Divisi, 
       CASE 
            WHEN (charindex('@', rtrim(replace(isnull(CAST(N.TXTFIELD AS nvarchar(100)), ''), '|', '@'))) > 0) 
                  THEN SUBSTRING(CAST(N.TXTFIELD AS Nvarchar(100)), LEN(LEFT(CAST(N.TXTFIELD AS nvarchar(100)), CHARINDEX('|', CAST(N.TXTFIELD AS NVarchar(100))))) + 1, LEN(RIGHT(CAST(N.TXTFIELD AS Nvarchar(100)), LEN(CAST(N.TXTFIELD AS NVarchar(100))) - CHARINDEX('|', CAST(N.TXTFIELD AS NVarchar(100)))))) 
            ELSE isnull(CAST(N.TXTFIELD AS Nvarchar(100)), '') 
       END AS [Sub.Div], 
       C.CRLMTAMT AS [Credit Limit], 
       C.CREATDDT AS Created, 
       CASE WHEN C.INACTIVE = 0 THEN 'Yes' ELSE 'No' END AS ACTIVE, 
        NULLIF(
            LTRIM(
                  RTRIM( 
                        ISNULL(NULLIF(LTRIM(RTRIM(C.ADDRESS1)), ''), '') +
                        CASE 
                              WHEN LTRIM(RTRIM(C.ADDRESS1)) <> '' AND LTRIM(RTRIM(C.ADDRESS2)) <> '' 
                                    THEN ', ' 
                              ELSE '' 
                        END +
                        ISNULL(NULLIF(LTRIM(RTRIM(C.ADDRESS2)), ''), '') +
                        CASE 
                              WHEN (LTRIM(RTRIM(C.ADDRESS1)) <> '' OR LTRIM(RTRIM(C.ADDRESS2)) <> '') AND LTRIM(RTRIM(C.ADDRESS3)) <> '' 
                                    THEN ', ' 
                              ELSE '' 
                        END +
                        ISNULL(NULLIF(LTRIM(RTRIM(C.ADDRESS3)), ''), '')
                  )
            ),
       ''
       ) AS Address,
        SYSUTCDATETIME() AS load_ts
FROM     
       raw_gp.RM00101 AS C 
LEFT OUTER JOIN
       raw_gp.RM00201 AS B ON C.CUSTCLAS = B.CLASSID 
LEFT OUTER JOIN
       raw_gp.SY03900 AS N ON N.NOTEINDX = B.NOTEINDX 
   ;
END;