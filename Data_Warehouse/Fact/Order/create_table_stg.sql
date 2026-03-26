USE [DW_DEV]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [stg].[order](
	[Customer No] 	[varchar](15) NOT NULL,
	[Item No] 		[varchar](31) NULL,
	[Order No] 		[varchar](21) NULL,
	[PO No] 		[varchar](21) NULL,
	[Site] 			[char](11) NULL,
	[Order Date] 	[datetime] NULL,
	[Req.Ship Date] [datetime] NULL,
	[Order Qty] 	[numeric](38, 7) NULL,
	[Fulfil Qty] 	[numeric](38, 7) NULL,
	[Base Qty] 		[numeric](38, 7) NULL,
	[Disc Amount] 	[numeric](38, 7) NULL,
	[Order Amount] 	[numeric](21, 5) NULL,
	[table_source]	[varchar](10) NOT NULL,
	[load_ts] 		[datetime2](7) NOT NULL
) ON [PRIMARY]
GO