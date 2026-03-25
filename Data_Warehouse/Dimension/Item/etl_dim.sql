USE [DW_DEV]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [etl].[load_dim_item]
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @now DATETIME2(7) = SYSUTCDATETIME();

    /*=====================================
      1. Update existing items (Type 1)
      =====================================*/
    UPDATE d
       SET
           d.item_desc       = s.item_desc,
           d.item_class_cd   = s.item_class_cd,
           d.item_class_desc = s.item_class_desc,
           d.uom_schedule    = s.uom_schedule,
           d.base_uom        = s.base_uom,
           d.equiv_qty       = s.equiv_qty,
           d.update_ts       = @now
    FROM dim.item d
    JOIN stg.item s
      ON d.item_nbr    = s.item_nbr
     AND d.selling_uom = s.selling_uom;

    /*=====================================
      2. Insert new items
      =====================================*/
    INSERT INTO dim.item (
        item_nbr,
        selling_uom,
        item_desc,
        item_class_cd,
        item_class_desc,
        uom_schedule,
        base_uom,
        equiv_qty,
        is_active,
        load_ts,
        update_ts
    )
    SELECT
        s.item_nbr,
        s.selling_uom,
        s.item_desc,
        s.item_class_cd,
        s.item_class_desc,
        s.uom_schedule,
        s.base_uom,
        s.equiv_qty,
        1,
        @now,
        @now
    FROM stg.item s
    LEFT JOIN dim.item d
      ON d.item_nbr    = s.item_nbr
     AND d.selling_uom = s.selling_uom
    WHERE d.item_key IS NULL;

    /*=====================================
      3. Soft-delete (items no longer in STG)
      =====================================*/
    UPDATE d
       SET
           d.is_active = 0,
           d.update_ts = @now
    FROM dim.item d
    LEFT JOIN stg.item s
      ON d.item_nbr    = s.item_nbr
     AND d.selling_uom = s.selling_uom
    WHERE s.item_nbr IS NULL;
END;