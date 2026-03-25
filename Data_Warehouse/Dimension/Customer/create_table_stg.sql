USE [DW_DEV]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [stg].[customer](
	[Customer No] [varchar](15) NOT NULL,
	[Customer Name] [varchar](65) NOT NULL,
	[Customer Class] [varchar](15) NOT NULL,
	[Salesman ID] [varchar](15) NOT NULL,
	[Branch ID] [varchar](15) NOT NULL,
	[Divisi] [nvarchar](100) NULL,
	[Sub.Div] [nvarchar](100) NULL,
	[Credit Limit] [numeric](19, 5) NOT NULL,
	[Created] [datetime] NOT NULL,
	[ACTIVE] [varchar](3) NOT NULL,
	[Address] [varchar](187) NULL,
	[load_ts] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_stg_customer] PRIMARY KEY CLUSTERED 
(
	[Customer No] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO