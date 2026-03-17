USE [DW_DEV]
GO
/****** Object:  StoredProcedure [etl].[rebuild_stg_sales]    Script Date: 17/03/2026 13:56:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [etl].[rebuild_stg_sales]
AS
BEGIN
    SET NOCOUNT ON;

    TRUNCATE TABLE stg.sales;

	INSERT INTO stg.sales (
		[Customer No],
		[Item No],
		[Trx No],
		[Trx Date],
		[Trx Type],
		[Invoice Amount],
		[Disc Total Amount],
		[DPP Invoice],
		[Sales Nett],
		[Gross Profit],
		table_source,
		load_ts
	)
	SELECT
		H.CUSTNMBR									AS [Customer No],
		I.ITEMNMBR									AS [Item No],
		H.SOPNUMBE									AS [Trx No],
		H.DOCDATE									AS [Trx Date],
		H.SOPTYPE									AS [Trx Type],
		CASE 
			WHEN H.SOPTYPE = 3 THEN COALESCE(D.REMPRICE,0) 
			ELSE COALESCE(D.REMPRICE,0) * -1 
		END											AS [Invoice Amount],
		CASE 
			WHEN H.SOPTYPE = 3 THEN D.MRKDNAMT * COALESCE(D.QTYFULFI,0)
			ELSE D.MRKDNAMT  * COALESCE(D.QUANTITY,0) * -1 
		END											AS [Disc Total Amount],
		CASE 
			WHEN H.SOPTYPE = 3 THEN
				CASE D.TAXSCHID 
					WHEN 'VAT-OUT' THEN COALESCE(D.REMPRICE,0) / 1.1                      
					WHEN 'VAT-OUT 11' THEN COALESCE(D.REMPRICE,0) / 1.11                      
					ELSE COALESCE(D.REMPRICE,0) 
				END 
			ELSE 
				CASE D.TAXSCHID 
					WHEN 'VAT-OUT' THEN COALESCE(D.REMPRICE,0) / 1.1 *-1                     
					WHEN 'VAT-OUT 11' THEN COALESCE(D.REMPRICE,0) / 1.11 *-1                     
					ELSE COALESCE(D.REMPRICE,0)*-1 
				END 
		END											AS [DPP Invoice],
		CASE 
			WHEN H.SOPTYPE = 3 THEN
			CASE D.TAXSCHID 
				WHEN 'VAT-OUT' THEN COALESCE(D.REMPRICE,0) / 1.1                      
				WHEN 'VAT-OUT 11' THEN COALESCE(D.REMPRICE,0) / 1.11                      
				ELSE COALESCE(D.REMPRICE,0) 
			END 
			ELSE 0
		END											AS [Sales Nett],
		CASE 
			WHEN H.SOPTYPE = 3 THEN  
				CASE D.TAXSCHID 
					WHEN 'VAT-OUT' THEN ( (COALESCE(D.REMPRICE,0) / 1.1) - D.EXTDCOST ) 
					WHEN 'VAT-OUT 11' THEN ( (COALESCE(D.REMPRICE,0) / 1.11) - D.EXTDCOST ) 
					ELSE ( COALESCE(D.REMPRICE,0) - D.EXTDCOST ) 
				END
			ELSE
				CASE D.TAXSCHID 
					WHEN 'VAT-OUT' THEN ( (COALESCE(D.REMPRICE,0) / 1.1) - D.EXTDCOST ) * -1
					WHEN 'VAT-OUT 11' THEN ( (COALESCE(D.REMPRICE,0) / 1.11) - D.EXTDCOST ) *-1 
					ELSE ( COALESCE(D.REMPRICE,0) - D.EXTDCOST ) * -1 
				END 
		 END										AS [Gross Profit],
		'SOP30200'									AS table_source,
		SYSUTCDATETIME()                            AS load_ts
	FROM raw_gp.sop30200 H
	LEFT JOIN raw_gp.sop30300 D
		ON H.SOPTYPE = D.SOPTYPE AND H.SOPNUMBE = D.SOPNUMBE
	LEFT JOIN raw_gp.iv00101 I
		ON I.ITEMNMBR = D.ITEMNMBR
	WHERE
		H.SOPTYPE in (3,4) AND H.VOIDSTTS = 0
	UNION
	SELECT
		H.CUSTNMBR									AS [Customer No],
		I.ITEMNMBR									AS [Item No],
		H.SOPNUMBE									AS [Trx No],
		H.DOCDATE									AS [Trx Date],
		H.SOPTYPE									AS [Trx Type],
		CASE 
			WHEN H.SOPTYPE = 3 THEN COALESCE(D.REMPRICE,0) 
			ELSE COALESCE(D.REMPRICE,0) * -1 
		END											AS [Invoice Amount],
		CASE 
			WHEN H.SOPTYPE = 3 THEN D.MRKDNAMT * COALESCE(D.QTYFULFI,0)
			ELSE D.MRKDNAMT  * COALESCE(D.QUANTITY,0) * -1 
		END											AS [Disc Total Amount],
		CASE 
			WHEN H.SOPTYPE = 3 THEN
				CASE D.TAXSCHID 
					WHEN 'VAT-OUT' THEN COALESCE(D.REMPRICE,0) / 1.1                      
					WHEN 'VAT-OUT 11' THEN COALESCE(D.REMPRICE,0) / 1.11                      
					ELSE COALESCE(D.REMPRICE,0) 
				END 
			ELSE 
				CASE D.TAXSCHID 
					WHEN 'VAT-OUT' THEN COALESCE(D.REMPRICE,0) / 1.1 *-1                     
					WHEN 'VAT-OUT 11' THEN COALESCE(D.REMPRICE,0) / 1.11 *-1                     
					ELSE COALESCE(D.REMPRICE,0)*-1 
				END 
		END											AS [DPP Invoice],
		CASE 
			WHEN H.SOPTYPE = 3 THEN
			CASE D.TAXSCHID 
				WHEN 'VAT-OUT' THEN COALESCE(D.REMPRICE,0) / 1.1                      
				WHEN 'VAT-OUT 11' THEN COALESCE(D.REMPRICE,0) / 1.11                      
				ELSE COALESCE(D.REMPRICE,0) 
			END 
			ELSE 0
		END											AS [Sales Nett],
		CASE 
			WHEN H.SOPTYPE = 3 THEN  
				CASE D.TAXSCHID 
					WHEN 'VAT-OUT' THEN ( (COALESCE(D.REMPRICE,0) / 1.1) - D.EXTDCOST ) 
					WHEN 'VAT-OUT 11' THEN ( (COALESCE(D.REMPRICE,0) / 1.11) - D.EXTDCOST ) 
					ELSE ( COALESCE(D.REMPRICE,0) - D.EXTDCOST ) 
				END
			ELSE
				CASE D.TAXSCHID 
					WHEN 'VAT-OUT' THEN ( (COALESCE(D.REMPRICE,0) / 1.1) - D.EXTDCOST ) * -1
					WHEN 'VAT-OUT 11' THEN ( (COALESCE(D.REMPRICE,0) / 1.11) - D.EXTDCOST ) *-1 
					ELSE ( COALESCE(D.REMPRICE,0) - D.EXTDCOST ) * -1 
				END 
		END											AS [Gross Profit],
		'SOP10100'									AS table_source,
		SYSUTCDATETIME()                            AS load_ts
	FROM raw_gp.sop10100 H
	LEFT JOIN raw_gp.sop10200 D
		ON H.SOPTYPE = D.SOPTYPE AND H.SOPNUMBE = D.SOPNUMBE
	LEFT JOIN raw_gp.iv00101 I
		ON I.ITEMNMBR = D.ITEMNMBR
	WHERE
		H.SOPTYPE in (3,4) AND H.VOIDSTTS = 0
END;