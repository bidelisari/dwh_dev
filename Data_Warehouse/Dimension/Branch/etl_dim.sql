USE [DW_DEV]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [etl].[load_dim_branch]
AS
BEGIN
    SET NOCOUNT ON;

    MERGE dim.branch AS tgt
    USING (
        SELECT
            [Branch ID],
            Cabang,
            Region,
            [Lead Time]
        FROM stg.branch
    ) src
      ON tgt.[Branch ID] = src.[Branch ID]
     AND tgt.effective_to IS NULL

    WHEN MATCHED AND (
           ISNULL(tgt.Cabang, '')    <> ISNULL(src.Cabang, '')
        OR ISNULL(tgt.Region, '')         <> ISNULL(src.Region, '')
        OR ISNULL(tgt.[Lead Time], '') <> ISNULL(src.[Lead Time], '')
    ) THEN
        UPDATE SET
            Cabang         = src.Cabang,
            Region         = src.Region,
            [Lead Time]    = src.[Lead Time],
            load_ts        = SYSUTCDATETIME()

    WHEN NOT MATCHED THEN
        INSERT (
            [Branch ID],
            Cabang,
            Region,
            [Lead Time],
            load_ts
        )
        VALUES (
            src.[Branch ID],
            src.Cabang,
            src.Region,
            src.[Lead Time],
            SYSUTCDATETIME()
        );
END;