USE [DW_DEV]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dim].[branch](
	[branch_sk] 		[int] IDENTITY(1,1) NOT NULL,
	[Branch ID] 		[varchar](15) NOT NULL,
	[Cabang]    		[varchar](31) NULL,
	[Region]    		[varchar](21) NULL,
	[Lead Time] 		[varchar](15) NULL,
	[is_active] 		[bit] NOT NULL,
	[effective_from]	[datetime2](7) NOT NULL,
	[effective_to] 		[datetime2](7) NULL,
	[load_ts] 			[datetime2](7) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[branch_sk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dim].[branch] ADD  DEFAULT ((1)) FOR [is_active]
GO

ALTER TABLE [dim].[branch] ADD  DEFAULT (sysutcdatetime()) FOR [effective_from]
GO