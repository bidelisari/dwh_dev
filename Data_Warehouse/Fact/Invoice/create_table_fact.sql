USE [DW_DEV]
GO

/****** Object:  Table [fact].[sales]    Script Date: 17/03/2026 13:45:45 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [fact].[sales](
	[sales_key] [int] IDENTITY(1,1) NOT NULL,
	[Customer No] [varchar](15) NOT NULL,
	[Item No] [varchar](31) NULL,
	[Trx No] [varchar](21) NULL,
	[Trx Date] [datetime] NULL,
	[Trx Type] [varchar](6) NULL,
	[Invoice Amount] [numeric](21, 5) NULL,
	[Disc Total Amount] [numeric](38, 7) NULL,
	[DPP Invoice] [numeric](38, 7) NULL,
	[Sales Nett] [numeric](38, 7) NULL,
	[Gross Profit] [numeric](38, 7) NULL,
	[table_source] [varchar](10) NOT NULL,
	[load_ts] [datetime2](7) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[sales_key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO