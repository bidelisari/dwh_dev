USE [DW_DEV]
GO

/****** Object:  Table [stg].[sales]    Script Date: 17/03/2026 13:55:15 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [stg].[sales](
	[Customer No] [varchar](15) NOT NULL,
	[Item No] [varchar](31) NULL,
	[Trx No] [varchar](21) NULL,
	[Trx Date] [datetime] NULL,
	[Trx Type] [varchar](6) NULL,
	[Invoice Amount] [numeric](21, 5) NULL,
	[Disc Total Amount] [numeric](38, 7) NULL,
	[DPP Invoice] [numeric](27, 9) NULL,
	[Sales Nett] [numeric](25, 9) NULL,
	[Gross Profit] [numeric](27, 9) NULL,
	[table_source] [varchar](10) NOT NULL,
	[load_ts] [datetime2](7) NOT NULL
) ON [PRIMARY]
GO
