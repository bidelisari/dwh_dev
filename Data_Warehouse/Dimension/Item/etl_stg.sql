USE [DW_DEV]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [etl].[rebuild_stg_item]
AS
BEGIN
    SET NOCOUNT ON;

    TRUNCATE TABLE stg.item;

    INSERT INTO stg.item (
        item_nbr,
        item_desc,
        item_class_cd,
        item_class_desc,
        uom_schedule,
        selling_uom,
        base_uom,
        equiv_qty,
        load_ts
    )
    SELECT
        I.ITEMNMBR                                   AS item_nbr,
        I.ITEMDESC                                   AS item_desc,
        I.ITMCLSCD                                   AS item_class_cd,
        C.ITMCLSDC                                   AS item_class_desc,
        I.UOMSCHDL                                   AS uom_schedule,
        I.SELNGUOM                                   AS selling_uom,
        H.BASEUOFM                                   AS base_uom,
        D.EQUOMQTY                                   AS equiv_qty,
        SYSUTCDATETIME()                              AS load_ts
    FROM raw_gp.iv00101 I
    LEFT JOIN raw_gp.iv40400 C
        ON I.ITMCLSCD = C.ITMCLSCD
    LEFT JOIN raw_gp.iv40201 H
        ON I.UOMSCHDL = H.UOMSCHDL
    LEFT JOIN raw_gp.iv40202 D
        ON  I.UOMSCHDL = D.UOMSCHDL
        AND I.SELNGUOM = D.UOFM
        AND H.BASEUOFM = D.EQUIVUOM;
END;