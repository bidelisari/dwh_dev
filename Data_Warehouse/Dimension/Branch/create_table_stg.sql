USE [DW_DEV]
GO

/****** Object:  Table [stg].[branch]    Script Date: 25/03/2026 14:40:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [stg].[branch](
	[Branch ID] [varchar](15) NOT NULL,
	[Cabang] [varchar](31) NOT NULL,
	[Region] [varchar](21) NOT NULL,
	[Lead Time] [varchar](15) NOT NULL,
	[load_ts] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_stg_branch] PRIMARY KEY CLUSTERED 
(
	[Branch ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO