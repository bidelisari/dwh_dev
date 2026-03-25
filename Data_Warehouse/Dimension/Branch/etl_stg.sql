USE [DW_DEV]
GO
/****** Object:  StoredProcedure [etl].[rebuild_stg_branch]    Script Date: 25/03/2026 14:42:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [etl].[rebuild_stg_branch]
AS
BEGIN
    SET NOCOUNT ON;

    TRUNCATE TABLE stg.branch;

    INSERT INTO stg.branch (
        [Branch ID],
        Cabang,
        Region,
        [Lead Time],
        load_ts
    )
    SELECT
        RTRIM(SALSTERR)  AS [Branch ID],
        RTRIM(SLTERDSC)  AS Cabang,
        RTRIM(STMGRLNM)  AS Region,
        RTRIM(STMGRMNM)  AS [Lead Time],
        SYSUTCDATETIME() AS load_ts
    FROM raw_gp.rm00303;
END;
