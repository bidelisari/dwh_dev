USE [DW_DEV]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [stg].[salesperson](
	[Salesman ID] [varchar](15) NOT NULL,
	[Salesman] [varchar](100) NOT NULL,
	[Cabang] [varchar](100) NULL,
	[Branch ID] [varchar](15) NOT NULL,
	[Region] [varchar](21) NULL,
	[Branch PIC] [varchar](100) NOT NULL,
	[Person Only] [varchar](15) NOT NULL,
	[ACTIVE] [varchar](3) NOT NULL,
	[load_ts] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_stg_salesperson] PRIMARY KEY CLUSTERED 
(
	[Salesman ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO