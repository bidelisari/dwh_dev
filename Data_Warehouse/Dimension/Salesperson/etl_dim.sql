USE [DW_DEV]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [etl].[load_dim_salesperson]
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    DECLARE @process_ts DATETIME2(7) = SYSUTCDATETIME();

    BEGIN TRAN;

    /*=========================================================
      STEP 1: Expire current records where Type-2 attributes
              have changed
    =========================================================*/
    UPDATE d
    SET
        effective_to = DATEADD(SECOND, -1, s.load_ts),
        is_current   = 0,
        load_ts      = @process_ts
    FROM dim.salesperson d
    JOIN stg.salesperson s
        ON d.[salesman id] = s.[Salesman ID]
    WHERE d.is_current = 1
      AND (
            d.[Branch ID]   <> s.[Branch ID]
         OR d.[Branch PIC]  <> s.[Branch PIC]
         OR ISNULL(d.Cabang,'') <> ISNULL(s.Cabang,'')
         OR ISNULL(d.Region,'') <> ISNULL(s.Region,'')
         OR d.ACTIVE <> s.ACTIVE
      );

    /*=========================================================
      STEP 2: Insert new dimension rows
              - brand new salespeople
              - salespeople with Type-2 changes
    =========================================================*/
    INSERT INTO dim.salesperson (
        [Salesman ID],
        Salesman,
        Cabang,   
        [Branch ID],
        Region,
        [Branch PIC],
        ACTIVE,
        [Person Only],             
        effective_from,
        effective_to,
        is_current,
        load_ts
    )
    SELECT
        s.[Salesman ID],
        s.Salesman,
        s.Cabang,    
        s.[Branch ID],
        s.Region,
        s.[Branch PIC],
        s.ACTIVE,
        s.[Person Only],       
        s.load_ts,
        '9999-12-31',
        1,
        @process_ts
    FROM stg.salesperson s
    LEFT JOIN dim.salesperson d
        ON d.[salesman id] = s.[Salesman ID]
       AND d.is_current = 1
    WHERE
        d.[salesman id] IS NULL
        OR (
            d.[Branch ID]   <> s.[Branch ID]
         OR d.[Branch PIC]  <> s.[Branch PIC]
         OR ISNULL(d.Cabang,'') <> ISNULL(s.Cabang,'')
         OR ISNULL(d.Region,'') <> ISNULL(s.Region,'')
         OR d.ACTIVE <> s.ACTIVE
        );

    /*=========================================================
      STEP 3: Type-1 overwrite (non-historical attributes)
    =========================================================*/
    UPDATE d
    SET
        Salesman = s.Salesman,
        [Person Only]   = s.[Person Only],
        load_ts       = @process_ts
    FROM dim.salesperson d
    JOIN stg.salesperson s
        ON d.[Salesman ID] = s.[Salesman ID]
    WHERE d.is_current = 1;

    COMMIT TRAN;
END;