USE [DW_DEV]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dim].[customer](
	[customer_key]  	[int] IDENTITY(1,1) NOT NULL,
	[Customer No]   	[varchar](15) NOT NULL,
	[Customer Name] 	[varchar](65) NULL,
	[Customer Class]	[varchar](15) NULL,
	[Salesman ID] 		[varchar](15) NULL,
	[Branch ID]   		[varchar](15) NULL,
	[Divisi]      		[nvarchar](100) NULL,
	[Sub.Div]     		[nvarchar](100) NULL,
	[Credit Limit] 		[numeric](19, 5) NULL,
	[Created]      		[datetime] NULL,
	[ACTIVE]       		[varchar](3) NOT NULL,
	[Address]      		[nvarchar](255) NULL,
	[row_hash]     		[binary](32) NOT NULL,
	[effective_ts] 		[datetime2](0) NOT NULL,
	[load_ts] 			[datetime2](7) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[customer_key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO