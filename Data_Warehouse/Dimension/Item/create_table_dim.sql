USE [DW_DEV]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dim].[item](
	[item_key] [int] IDENTITY(1,1) NOT NULL,
	[item_nbr] [varchar](31) NOT NULL,
	[selling_uom] [varchar](11) NOT NULL,
	[item_desc] [varchar](100) NULL,
	[item_class_cd] [varchar](11) NULL,
	[item_class_desc] [varchar](31) NULL,
	[uom_schedule] [varchar](11) NULL,
	[base_uom] [varchar](11) NULL,
	[equiv_qty] [numeric](19, 5) NULL,
	[is_active] [bit] NOT NULL,
	[load_ts] [datetime2](7) NOT NULL,
	[update_ts] [datetime2](7) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[item_key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dim].[item] ADD  DEFAULT ((1)) FOR [is_active]
GO