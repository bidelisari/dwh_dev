USE [DW_DEV]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [etl].[load_dim_customer]
AS
BEGIN
    SET NOCOUNT ON;

    ;WITH src AS (
        SELECT
            [Customer No]     AS [Customer No],
            [Customer Name]   AS [Customer Name],
            [Customer Class]  AS [Customer Class],
            [Salesman ID]     AS [Salesman ID],
            [Branch ID]       AS [Branch ID],
            Divisi,
            [Sub.Div]         AS [Sub.Div],
            [Credit Limit]    AS [Credit Limit],
            Created,
            ACTIVE,
            Address,

            HASHBYTES('SHA2_256',
                CONCAT(
                    ISNULL([Customer Name], ''),
                    ISNULL([Customer Class], ''),
                    ISNULL([Salesman ID], ''),
                    ISNULL([Branch ID], ''),
                    ISNULL(Divisi, ''),
                    ISNULL([Sub.Div], ''),
                    ISNULL(CAST([Credit Limit] AS VARCHAR(50)), ''),
                    ISNULL(CONVERT(VARCHAR(23), Created, 121), ''),
                    ISNULL(ACTIVE, ''),
                    ISNULL(Address, '')
                )
            ) AS row_hash
        FROM stg.customer
    )

    MERGE dim.customer AS tgt
    USING src
       ON tgt.[Customer No] = src.[Customer No]

    WHEN MATCHED
     AND tgt.row_hash <> src.row_hash
    THEN UPDATE SET
        [Customer Name]  = src.[Customer Name],
        [Customer Class] = src.[Customer Class],
        [Salesman ID]    = src.[Salesman ID],
        [Branch ID]      = src.[Branch ID],
        Divisi           = src.Divisi,
        [Sub.Div]        = src.[Sub.Div],
        [Credit Limit]   = src.[Credit Limit],
        Created          = src.Created,
        ACTIVE           = src.ACTIVE,
        Address          = src.Address,
        row_hash         = src.row_hash,
        effective_ts     = SYSUTCDATETIME(),
        load_ts          = SYSUTCDATETIME()

    WHEN NOT MATCHED THEN
        INSERT (
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
            row_hash,
            effective_ts,
            load_ts
        )
        VALUES (
            src.[Customer No],
            src.[Customer Name],
            src.[Customer Class],
            src.[Salesman ID],
            src.[Branch ID],
            src.Divisi,
            src.[Sub.Div],
            src.[Credit Limit],
            src.Created,
            src.ACTIVE,
            src.Address,
            src.row_hash,
            SYSUTCDATETIME(),
            SYSUTCDATETIME()
        );
END;