USE [DW_DEV]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [stg].[item](
	[item_nbr] [varchar](31) NOT NULL,
	[item_desc] [varchar](100) NULL,
	[item_class_cd] [varchar](11) NULL,
	[item_class_desc] [varchar](31) NULL,
	[uom_schedule] [varchar](11) NULL,
	[selling_uom] [varchar](11) NULL,
	[base_uom] [varchar](11) NULL,
	[equiv_qty] [numeric](19, 5) NULL,
	[load_ts] [datetime2](7) NOT NULL
) ON [PRIMARY]
GO