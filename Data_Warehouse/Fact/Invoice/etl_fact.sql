USE [DW_DEV]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [etl].[load_fact_sales]
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    WITH src AS (
        SELECT
            [Customer No]       AS [Customer No],
            [Item No]           AS [Item No],
            [Trx No]            AS [Trx No],
            [Trx Date]          AS [Trx Date],
            [Trx Type]          AS [Trx Type],
            [Invoice Amount]    AS [Invoice Amount],
            [Disc Total Amount] AS [Disc Total Amount],
            [DPP Invoice]       AS [DPP Invoice],
            [Sales Nett]        AS [Sales Nett],
            [Gross Profit]      AS [Gross Profit]
        FROM stg.sales
    )

    MERGE fact.sales AS tgt
    USING src
       ON tgt.[Customer No] = src.[Customer No]
       AND tgt.[Item No]     = src.[Item No]
       AND tgt.[Trx No]     = src.[Trx No]

    WHEN MATCHED
    THEN UPDATE SET
        [Trx Date]          = src.[Trx Date],
        [Invoice Amount]    = src.[Invoice Amount],
        [Disc Total Amount] = src.[Disc Total Amount],
        [DPP Invoice]       = src.[DPP Invoice],
        [Sales Nett]        = src.[Sales Nett],
        [Gross Profit]      = src.[Gross Profit],
        load_ts             = SYSUTCDATETIME()

    WHEN NOT MATCHED THEN
        INSERT (
            [Customer No]       ,
            [Item No]           ,
            [Trx No]            ,
            [Trx Date]          ,
            [Invoice Amount]    ,
            [Disc Total Amount] ,
            [DPP Invoice]       ,
            [Sales Nett]        ,
            [Gross Profit]      ,
            load_ts
        )
        VALUES (
            src.[Customer No]       ,
            src.[Item No]           ,
            src.[Trx No]            ,
            src.[Trx Date]          ,
            src.[Trx Type]          ,
            src.[Invoice Amount]    ,
            src.[Disc Total Amount] ,
            src.[DPP Invoice]       ,
            src.[Sales Nett]        ,
            src.[Gross Profit]      ,
            SYSUTCDATETIME()
        );

END;