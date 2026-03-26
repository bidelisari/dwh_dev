USE [DW_DEV]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [etl].[rebuild_stg_order]
AS
BEGIN
    SET NOCOUNT ON;

    TRUNCATE TABLE stg.[order];

	INSERT INTO stg.[order] (
		[Customer No]	,
		[Item No]		,
		[Order No]		,
		[PO No]			,
		[Site]			,
		[Order Date]	,
		[Req.Ship Date]	,
		[Order Qty]		,
		[Fulfil Qty]	,
		[Base Qty]		,
		[Disc Amount]	,
		[Order Amount]	,
		table_source	,
		load_ts
	)
	SELECT
		H.CUSTNMBR									AS [Customer No],
		I.ITEMNMBR									AS [Item No],
		H.SOPNUMBE									AS [Order No],
		H.CSTPONBR									AS [PO No],
		H.LOCNCODE									AS [Site],
		H.DOCDATE									AS [Order Date],
		H.REQSHIPDATE								AS [Req. Ship Date],
		D.QUANTITY									AS [Order Qty],
		D.QTYFULFI									AS [Fulfil Qty],
		CASE 
			WHEN D.QTYFULFI <> 0 OR D.QUANTITY <> 0 THEN D.QTYBSUOM * COALESCE(D.QTYFULFI,0)    
			ELSE 0 
		END											AS [Qty Base],
		D.MRKDNAMT * COALESCE(D.QTYFULFI,0)			AS [Disc Amount],
		COALESCE(D.REMPRICE,0)						AS [Order Amount],
		'SOP10100'									AS table_source,
		SYSUTCDATETIME()                            AS load_ts
	FROM raw_gp.sop10100 H
	LEFT JOIN raw_gp.sop10200 D
		ON H.SOPTYPE = D.SOPTYPE AND H.SOPNUMBE = D.SOPNUMBE
	LEFT JOIN raw_gp.iv00101 I
		ON I.ITEMNMBR = D.ITEMNMBR
	WHERE
		H.SOPTYPE = 2 AND H.VOIDSTTS = 0
END;