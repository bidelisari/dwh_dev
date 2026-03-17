USE [DW_DEV]
GO
/****** Object:  StoredProcedure [etl].[load_fact_order]    Script Date: 17/03/2026 14:02:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [etl].[load_fact_order]
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    WITH src AS (
        SELECT
            [Customer No]       AS [Customer No],
            [Item No]           AS [Item No],
            [Order No]          AS [Order No],
            [PO No]             AS [PO No],
            [Site]              AS [Site],
            [Order Date]        AS [Order Date],
            [Req.Ship Date]     AS [Req.Ship Date],
            [Order Qty]         AS [Order Qty],
            [Fulfil Qty]        AS [Fulfil Qty],
            [Base Qty]          AS [Base Qty],
            [Disc Amount]       AS [Disc Amount],
            [Order Amount]      AS [Order Amount]
        FROM stg.[order]
    )

    MERGE fact.[order] AS tgt
    USING src
       ON tgt.[Customer No] = src.[Customer No]
       AND tgt.[Item No]    = src.[Item No]
       AND tgt.[Order No]   = src.[Order No]

    WHEN MATCHED
    THEN UPDATE SET
        [Disc Amount]       = src.[Disc Amount],
        [Order Amount]      = src.[Order Amount],
        load_ts             = SYSUTCDATETIME()

    WHEN NOT MATCHED THEN
        INSERT (
            [Customer No]       ,
            [Item No]           ,
            [Order No]          ,
            [PO No]             ,
            [Site]              ,
            [Order Date]        ,
            [Req.Ship Date]     ,
            [Order Qty]         ,
            [Fulfil Qty]        ,
            [Base Qty]          ,
            [Disc Amount]       ,
            [Order Amount]      ,
            table_source        ,
            load_ts
        )
        VALUES (
            src.[Customer No]   ,
            src.[Item No]       ,
            src.[Order No]      ,
            src.[PO No]         ,
            src.[Site]          ,
            src.[Order Date]    ,
            src.[Req.Ship Date] ,
            src.[Order Qty]     ,
            src.[Fulfil Qty]    ,
            src.[Base Qty]      ,
            src.[Disc Amount]   ,
            src.[Order Amount]  ,
            'SOP10100'          ,
            SYSUTCDATETIME()
        );

END;