USE [DW_DEV]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER   PROCEDURE [etl].[rebuild_stg_salesperson]
AS
BEGIN
    SET NOCOUNT ON;

    TRUNCATE TABLE stg.salesperson;

    INSERT INTO stg.salesperson (
        [Salesman ID],
        Salesman,
        Cabang,
        [Branch ID],
        Region,
        [Branch PIC],  
        [Person Only],       
        ACTIVE,       
        load_ts
    )
    SELECT DISTINCT
        LTRIM(RTRIM(S.SLPRSNID)) AS [Salesman ID],
        CASE 
            WHEN LTRIM(RTRIM(S.SPRSNSMN)) <> '' 
            THEN UPPER(
                    LTRIM(RTRIM(
                        CONCAT(
                            LTRIM(RTRIM(S.SLPRSNFN)), ' ',
                            LTRIM(RTRIM(S.SPRSNSMN)), ' ',
                            LTRIM(RTRIM(S.SPRSNSLN))
                        )
                    ))
                 )
            ELSE UPPER(
                    LTRIM(RTRIM(
                        CONCAT(
                            LTRIM(RTRIM(S.SLPRSNFN)), ' ',
                            LTRIM(RTRIM(S.SPRSNSLN))
                        )
                    ))
                 )
        END AS Salesman,
        UPPER(LTRIM(RTRIM(T.SLTERDSC))) AS Cabang,
        S.SALSTERR AS [Branch ID],
        T.STMGRLNM AS Region,
        CASE 
            WHEN LTRIM(RTRIM(S.COUNTRY)) <> '' 
            THEN UPPER(S.COUNTRY) 
            ELSE UPPER(T.SLTERDSC) 
        END AS [Branch PIC],
        CASE 
            WHEN S.EMPLOYID = 'SYSONLY' THEN 'NO'
            ELSE 'YES'
        END AS [Person Only],        
        CASE 
            WHEN S.INACTIVE = 0 THEN 'YES' 
            ELSE 'NO' 
        END AS ACTIVE,
        SYSUTCDATETIME() AS load_ts
    FROM raw_gp.rm00301 AS S
    LEFT JOIN raw_gp.rm00303 AS T
        ON T.SALSTERR = S.SALSTERR
    WHERE
        LTRIM(RTRIM(
            UPPER(
                CONCAT(
                    LTRIM(RTRIM(S.SLPRSNFN)), ' ',
                    LTRIM(RTRIM(S.SPRSNSMN)), ' ',
                    LTRIM(RTRIM(S.SPRSNSLN))
                )
            )
        )) <> ''
        AND S.SLPRSNID <> 'QA-IT';
END;