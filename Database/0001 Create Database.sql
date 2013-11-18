USE [master]
GO

/****** Object:  Database [IOCMSCurrentConcept]    Script Date: 11/16/2013 12:35:48 PM ******/
CREATE DATABASE [IOCMSCurrentConcept]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'IOCMSCurrentConcept', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\IOCMSCurrentConcept.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'IOCMSCurrentConcept_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\IOCMSCurrentConcept_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO

ALTER DATABASE [IOCMSCurrentConcept] SET COMPATIBILITY_LEVEL = 110
GO

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [IOCMSCurrentConcept].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO

ALTER DATABASE [IOCMSCurrentConcept] SET ANSI_NULL_DEFAULT OFF 
GO

ALTER DATABASE [IOCMSCurrentConcept] SET ANSI_NULLS OFF 
GO

ALTER DATABASE [IOCMSCurrentConcept] SET ANSI_PADDING OFF 
GO

ALTER DATABASE [IOCMSCurrentConcept] SET ANSI_WARNINGS OFF 
GO

ALTER DATABASE [IOCMSCurrentConcept] SET ARITHABORT OFF 
GO

ALTER DATABASE [IOCMSCurrentConcept] SET AUTO_CLOSE OFF 
GO

ALTER DATABASE [IOCMSCurrentConcept] SET AUTO_CREATE_STATISTICS ON 
GO

ALTER DATABASE [IOCMSCurrentConcept] SET AUTO_SHRINK OFF 
GO

ALTER DATABASE [IOCMSCurrentConcept] SET AUTO_UPDATE_STATISTICS ON 
GO

ALTER DATABASE [IOCMSCurrentConcept] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO

ALTER DATABASE [IOCMSCurrentConcept] SET CURSOR_DEFAULT  GLOBAL 
GO

ALTER DATABASE [IOCMSCurrentConcept] SET CONCAT_NULL_YIELDS_NULL OFF 
GO

ALTER DATABASE [IOCMSCurrentConcept] SET NUMERIC_ROUNDABORT OFF 
GO

ALTER DATABASE [IOCMSCurrentConcept] SET QUOTED_IDENTIFIER OFF 
GO

ALTER DATABASE [IOCMSCurrentConcept] SET RECURSIVE_TRIGGERS OFF 
GO

ALTER DATABASE [IOCMSCurrentConcept] SET  DISABLE_BROKER 
GO

ALTER DATABASE [IOCMSCurrentConcept] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO

ALTER DATABASE [IOCMSCurrentConcept] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO

ALTER DATABASE [IOCMSCurrentConcept] SET TRUSTWORTHY OFF 
GO

ALTER DATABASE [IOCMSCurrentConcept] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO

ALTER DATABASE [IOCMSCurrentConcept] SET PARAMETERIZATION SIMPLE 
GO

ALTER DATABASE [IOCMSCurrentConcept] SET READ_COMMITTED_SNAPSHOT OFF 
GO

ALTER DATABASE [IOCMSCurrentConcept] SET HONOR_BROKER_PRIORITY OFF 
GO

ALTER DATABASE [IOCMSCurrentConcept] SET RECOVERY FULL 
GO

ALTER DATABASE [IOCMSCurrentConcept] SET  MULTI_USER 
GO

ALTER DATABASE [IOCMSCurrentConcept] SET PAGE_VERIFY CHECKSUM  
GO

ALTER DATABASE [IOCMSCurrentConcept] SET DB_CHAINING OFF 
GO

ALTER DATABASE [IOCMSCurrentConcept] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO

ALTER DATABASE [IOCMSCurrentConcept] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO

ALTER DATABASE [IOCMSCurrentConcept] SET  READ_WRITE 
GO

USE [IOCMSCurrentConcept]
GO

/****** Object:  Table [dbo].[InitialClassificaitons]    Script Date: 11/16/2013 12:45:23 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[InitialClassificaitons](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NULL,
	[Description] [varchar](50) NULL,
	[LastUpdatedDate] [datetime] NULL,
 CONSTRAINT [PK_InitialClassificaitons] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[InitialClassificaitons] ADD  CONSTRAINT [DF_InitialClassificaitons_LastUpdatedDate]  DEFAULT (getdate()) FOR [LastUpdatedDate]
GO

/****** Object:  Table [dbo].[TempClassificaitons]    Script Date: 11/16/2013 12:45:23 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[TempClassificaitons](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NULL,
	[Description] [varchar](50) NULL,
	[LastUpdatedDate] [datetime] NULL,
 CONSTRAINT [PK_TempClassificaitons] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[TempClassificaitons] ADD  CONSTRAINT [DF_TempClassificaitons_LastUpdatedDate]  DEFAULT (getdate()) FOR [LastUpdatedDate]
GO



/****** Object:  StoredProcedure [dbo].[uspInitialClassifications_Delete]    Script Date: 11/16/2013 12:37:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[uspInitialClassifications_Delete]
	@Id as int
AS
BEGIN
	SET NOCOUNT ON;

DELETE from [dbo].[InitialClassificaitons]
 WHERE [Id] = @Id
  
  END

GO

USE [IOCMSCurrentConcept]
GO

/****** Object:  StoredProcedure [dbo].[uspInitialClassifications_Get]    Script Date: 11/16/2013 12:37:55 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[uspInitialClassifications_Get] 
	@Id as int
AS
BEGIN
	SET NOCOUNT ON;

if @id is null
  begin
	SELECT [Id]
		  ,[Name]
		  ,[Description]
		  ,[LastUpdatedDate]
	FROM [dbo].[InitialClassificaitons]
  end
else
  begin
	SELECT [Id]
		  ,[Name]
		  ,[Description]
		  ,[LastUpdatedDate]

	FROM [dbo].[InitialClassificaitons]
	WHERE [Id] = @Id
  end
  END

GO

USE [IOCMSCurrentConcept]
GO

/****** Object:  StoredProcedure [dbo].[uspInitialClassifications_Insert]    Script Date: 11/16/2013 12:38:06 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[uspInitialClassifications_Insert]
	@Name as varchar(50)
	, @Description as varchar(50)
	, @NewId as int output
AS
BEGIN
	SET NOCOUNT ON;

INSERT INTO [dbo].[InitialClassificaitons] ([Name], [Description])
	VALUES (@Name, @Description)
  
	select @NewId = @@IDENTITY

END 

GO

USE [IOCMSCurrentConcept]
GO

/****** Object:  StoredProcedure [dbo].[uspInitialClassifications_Update]    Script Date: 11/16/2013 12:38:17 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[uspInitialClassifications_Update]
	@Id as int
	, @Name as varchar(50)
	, @Description as varchar(50)
AS
BEGIN
	SET NOCOUNT ON;

UPDATE [dbo].[InitialClassificaitons]
   SET [Name] = @Name
      ,[Description] = @Description
 WHERE [Id] = @Id
  
  END

GO

USE [IOCMSCurrentConcept]
GO

/****** Object:  StoredProcedure [dbo].[uspTempClassifications_Delete]    Script Date: 11/16/2013 12:38:38 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[uspTempClassifications_Delete]
	@Id as int
AS
BEGIN
	SET NOCOUNT ON;

DELETE from [dbo].[TempClassificaitons]
 WHERE [Id] = @Id
  
  END

GO

USE [IOCMSCurrentConcept]
GO

/****** Object:  StoredProcedure [dbo].[uspTempClassifications_Get]    Script Date: 11/16/2013 12:38:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[uspTempClassifications_Get] 
	@Id as int
AS
BEGIN
	SET NOCOUNT ON;

if @id is null
  begin
	SELECT [Id]
		  ,[Name]
		  ,[Description]
		  ,[LastUpdatedDate]
	FROM [dbo].[TempClassificaitons]
  end
else
  begin
	SELECT [Id]
		  ,[Name]
		  ,[Description]
		  ,[LastUpdatedDate]

	FROM [dbo].[TempClassificaitons]
	WHERE [Id] = @Id
  end
  END

GO

USE [IOCMSCurrentConcept]
GO

/****** Object:  StoredProcedure [dbo].[uspTempClassifications_Insert]    Script Date: 11/16/2013 12:38:56 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[uspTempClassifications_Insert]
	@Name as varchar(50)
	, @Description as varchar(50)
	, @NewId as int output
AS
BEGIN
	SET NOCOUNT ON;

INSERT INTO [dbo].[TempClassificaitons] ([Name], [Description])
	VALUES (@Name, @Description)
  
	select @NewId = @@IDENTITY

END 

GO

USE [IOCMSCurrentConcept]
GO

/****** Object:  StoredProcedure [dbo].[uspTempClassifications_Update]    Script Date: 11/16/2013 12:39:04 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[uspTempClassifications_Update]
	@Id as int
	, @Name as varchar(50)
	, @Description as varchar(50)
AS
BEGIN
	SET NOCOUNT ON;

UPDATE [dbo].[TempClassificaitons]
   SET [Name] = @Name
      ,[Description] = @Description
 WHERE [Id] = @Id
  
  END

GO