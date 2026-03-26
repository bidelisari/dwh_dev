USE [DW_DEV]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dim].[salesperson](
	[salesperson_key]	[int] IDENTITY(1,1) NOT NULL,
	[Salesman ID] 		[varchar](15) NOT NULL,
	[Salesman] 			[varchar](100) NOT NULL,
	[Cabang] 			[varchar](100) NULL,
	[Branch id] 		[varchar](15) NOT NULL,
	[Region] 			[varchar](21) NULL,
	[Branch PIC] 		[varchar](100) NOT NULL,
	[ACTIVE] 			[varchar](3) NOT NULL,
	[Person Only] 		[varchar](15) NOT NULL,
	[effective_from] 	[datetime2](7) NOT NULL,
	[effective_to] 		[datetime2](7) NOT NULL,
	[is_current] 		[bit] NOT NULL,
	[load_ts] 			[datetime2](7) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[salesperson_key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [uq_dim_salesperson] UNIQUE NONCLUSTERED 
(
	[Salesman ID] ASC,
	[effective_from] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO