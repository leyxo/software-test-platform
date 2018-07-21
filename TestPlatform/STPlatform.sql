USE [master]
GO
/****** Object:  Database [STPlatform]    Script Date: 2018/7/20 9:27:35 ******/
CREATE DATABASE [STPlatform]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'STPlatform', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\STPlatform.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'STPlatform_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\STPlatform_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [STPlatform] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [STPlatform].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [STPlatform] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [STPlatform] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [STPlatform] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [STPlatform] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [STPlatform] SET ARITHABORT OFF 
GO
ALTER DATABASE [STPlatform] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [STPlatform] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [STPlatform] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [STPlatform] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [STPlatform] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [STPlatform] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [STPlatform] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [STPlatform] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [STPlatform] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [STPlatform] SET  DISABLE_BROKER 
GO
ALTER DATABASE [STPlatform] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [STPlatform] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [STPlatform] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [STPlatform] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [STPlatform] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [STPlatform] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [STPlatform] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [STPlatform] SET RECOVERY FULL 
GO
ALTER DATABASE [STPlatform] SET  MULTI_USER 
GO
ALTER DATABASE [STPlatform] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [STPlatform] SET DB_CHAINING OFF 
GO
ALTER DATABASE [STPlatform] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [STPlatform] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [STPlatform] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'STPlatform', N'ON'
GO
USE [STPlatform]
GO
/****** Object:  Table [dbo].[department]    Script Date: 2018/7/20 9:27:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[department](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_department] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[model]    Script Date: 2018/7/20 9:27:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[model](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[path] [nvarchar](50) NULL,
	[menu_level] [int] NULL,
	[sort_order] [int] NULL,
 CONSTRAINT [PK_model] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[pass]    Script Date: 2018/7/20 9:27:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[pass](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[reg_status]    Script Date: 2018/7/20 9:27:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[reg_status](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_reg_status] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[role]    Script Date: 2018/7/20 9:27:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[role](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_role] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[role_model]    Script Date: 2018/7/20 9:27:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[role_model](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[role_id] [int] NOT NULL,
	[model_id] [int] NOT NULL,
 CONSTRAINT [PK_role_model] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[test]    Script Date: 2018/7/20 9:27:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[test](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](255) NOT NULL,
	[describe] [varchar](255) NULL,
	[creation_department_id] [int] NOT NULL,
	[creation_user_id] [int] NOT NULL,
	[creation_date] [datetime] NOT NULL,
 CONSTRAINT [PK__test__3213E83F2DEDBA05] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[test_case]    Script Date: 2018/7/20 9:27:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[test_case](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](255) NOT NULL,
	[precondition] [varchar](255) NULL,
	[process] [varchar](255) NULL,
	[suggestion] [varchar](255) NULL,
	[describe] [varchar](255) NULL,
	[times] [int] NULL,
	[pass] [int] NOT NULL,
	[type] [int] NULL,
	[creation_user_id] [int] NOT NULL,
	[creation_date] [datetime] NOT NULL,
	[version_id] [int] NOT NULL,
 CONSTRAINT [PK__test_cas__3213E83F920AABC4] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[test_issue_type]    Script Date: 2018/7/20 9:27:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[test_issue_type](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](255) NOT NULL,
	[describe] [varchar](255) NULL,
 CONSTRAINT [PK__test_iss__3213E83F46234C8D] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[test_version]    Script Date: 2018/7/20 9:27:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[test_version](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](255) NOT NULL,
	[test_id] [int] NOT NULL,
	[number] [varchar](50) NOT NULL,
	[start_time] [datetime] NULL,
	[end_time] [datetime] NULL,
	[creation_date] [datetime] NULL,
 CONSTRAINT [PK_test_version_id] PRIMARY KEY CLUSTERED 
(
	[id] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[users]    Script Date: 2018/7/20 9:27:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[users](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NULL,
	[password] [nvarchar](50) NULL,
	[email] [nvarchar](50) NULL,
	[phone] [nvarchar](13) NULL,
	[reg_datetime] [datetime] NULL,
	[department] [int] NULL,
	[role] [int] NULL,
	[reg_status] [int] NULL,
 CONSTRAINT [PK_users] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[department] ON 


INSERT [dbo].[department] ([id], [name]) VALUES (1, N'软件测试部门')
SET IDENTITY_INSERT [dbo].[department] OFF
SET IDENTITY_INSERT [dbo].[model] ON 

INSERT [dbo].[model] ([id], [name], [path], [menu_level], [sort_order]) VALUES (1, N'测试管理', N'', 1, 100)
INSERT [dbo].[model] ([id], [name], [path], [menu_level], [sort_order]) VALUES (2, N'测试系统', N'/platform/test.aspx', 2, 200)
INSERT [dbo].[model] ([id], [name], [path], [menu_level], [sort_order]) VALUES (3, N'测试记录', N'/platform/test_case.aspx', 2, 300)
INSERT [dbo].[model] ([id], [name], [path], [menu_level], [sort_order]) VALUES (4, N'新建测试记录', N'/platform/test_case_add.aspx', 3, 400)
INSERT [dbo].[model] ([id], [name], [path], [menu_level], [sort_order]) VALUES (5, N'编辑/删除', N'/platform/test_case_edit.aspx', 3, 500)
INSERT [dbo].[model] ([id], [name], [path], [menu_level], [sort_order]) VALUES (6, N'撰写开发回馈', N'/platform/test_case_describe.aspx', 3, 600)
INSERT [dbo].[model] ([id], [name], [path], [menu_level], [sort_order]) VALUES (7, N'测试报告', N'/platform/test_report.aspx', 3, 700)
INSERT [dbo].[model] ([id], [name], [path], [menu_level], [sort_order]) VALUES (8, N'部门成员', N'/platform/test_members.aspx', 2, 800)
INSERT [dbo].[model] ([id], [name], [path], [menu_level], [sort_order]) VALUES (9, N'基础数据管理', N'', 1, 900)
INSERT [dbo].[model] ([id], [name], [path], [menu_level], [sort_order]) VALUES (10, N'错误类型定义', N'/platform/basedata_manage_issuetype.aspx', 2, 1000)
INSERT [dbo].[model] ([id], [name], [path], [menu_level], [sort_order]) VALUES (11, N'新增/编辑/删除', N'/platform/basedata_manage_issuetype_edit.aspx', 3, 1100)
INSERT [dbo].[model] ([id], [name], [path], [menu_level], [sort_order]) VALUES (12, N'测试系统维护', N'/platform/basedata_manage_test.aspx', 2, 1200)
INSERT [dbo].[model] ([id], [name], [path], [menu_level], [sort_order]) VALUES (13, N'新增测试系统', N'/platform/basedata_manage_test_add.aspx', 3, 1300)
INSERT [dbo].[model] ([id], [name], [path], [menu_level], [sort_order]) VALUES (14, N'编辑/删除', N'/platform/basedata_manage_test_edit.aspx', 3, 1400)
INSERT [dbo].[model] ([id], [name], [path], [menu_level], [sort_order]) VALUES (15, N'测试版本维护', N'/platform/basedata_manage_test_version.aspx', 2, 1500)
INSERT [dbo].[model] ([id], [name], [path], [menu_level], [sort_order]) VALUES (16, N'新增版本', N'/platform/basedata_manage_test_version_add.aspx', 3, 1600)
INSERT [dbo].[model] ([id], [name], [path], [menu_level], [sort_order]) VALUES (17, N'编辑/删除', N'/platform/basedata_manage_test_version_edit.aspx', 3, 1700)
INSERT [dbo].[model] ([id], [name], [path], [menu_level], [sort_order]) VALUES (18, N'系统管理', N'', 1, 1800)
INSERT [dbo].[model] ([id], [name], [path], [menu_level], [sort_order]) VALUES (19, N'人员管理', N'/platform/system_manage_personnel.aspx', 2, 1900)
INSERT [dbo].[model] ([id], [name], [path], [menu_level], [sort_order]) VALUES (20, N'编辑/删除', N'/platform/system_manage_personnel_edit.aspx', 3, 2000)
INSERT [dbo].[model] ([id], [name], [path], [menu_level], [sort_order]) VALUES (21, N'部门管理', N'/platform/system_manage_department.aspx', 2, 2100)
INSERT [dbo].[model] ([id], [name], [path], [menu_level], [sort_order]) VALUES (22, N'新增/编辑/删除', N'/platform/system_manage_department_edit.aspx', 3, 2200)
INSERT [dbo].[model] ([id], [name], [path], [menu_level], [sort_order]) VALUES (23, N'权限管理', N'/platform/system_manage_authority.aspx', 2, 2300)
SET IDENTITY_INSERT [dbo].[model] OFF
SET IDENTITY_INSERT [dbo].[pass] ON 

INSERT [dbo].[pass] ([id], [name]) VALUES (1, N'通过')
INSERT [dbo].[pass] ([id], [name]) VALUES (2, N'未通过')
SET IDENTITY_INSERT [dbo].[pass] OFF
SET IDENTITY_INSERT [dbo].[reg_status] ON 

INSERT [dbo].[reg_status] ([id], [name]) VALUES (1, N'待审核')
INSERT [dbo].[reg_status] ([id], [name]) VALUES (2, N'正式人员')
INSERT [dbo].[reg_status] ([id], [name]) VALUES (3, N'离职人员')
INSERT [dbo].[reg_status] ([id], [name]) VALUES (4, N'审核未通过')
INSERT [dbo].[reg_status] ([id], [name]) VALUES (5, N'已删除')
SET IDENTITY_INSERT [dbo].[reg_status] OFF
SET IDENTITY_INSERT [dbo].[role] ON 

INSERT [dbo].[role] ([id], [name]) VALUES (1, N'管理员')
INSERT [dbo].[role] ([id], [name]) VALUES (4, N'开发人员')
INSERT [dbo].[role] ([id], [name]) VALUES (2, N'项目负责人')
INSERT [dbo].[role] ([id], [name]) VALUES (3, N'项目组成员')
SET IDENTITY_INSERT [dbo].[role] OFF
SET IDENTITY_INSERT [dbo].[role_model] ON 

INSERT [dbo].[role_model] ([id], [role_id], [model_id]) VALUES (1, 1, 1)
INSERT [dbo].[role_model] ([id], [role_id], [model_id]) VALUES (2, 2, 1)
INSERT [dbo].[role_model] ([id], [role_id], [model_id]) VALUES (3, 3, 1)
INSERT [dbo].[role_model] ([id], [role_id], [model_id]) VALUES (4, 1, 2)
INSERT [dbo].[role_model] ([id], [role_id], [model_id]) VALUES (5, 2, 2)
INSERT [dbo].[role_model] ([id], [role_id], [model_id]) VALUES (6, 3, 2)
INSERT [dbo].[role_model] ([id], [role_id], [model_id]) VALUES (7, 4, 2)
INSERT [dbo].[role_model] ([id], [role_id], [model_id]) VALUES (8, 1, 3)
INSERT [dbo].[role_model] ([id], [role_id], [model_id]) VALUES (9, 2, 3)
INSERT [dbo].[role_model] ([id], [role_id], [model_id]) VALUES (10, 3, 3)
INSERT [dbo].[role_model] ([id], [role_id], [model_id]) VALUES (11, 4, 3)
INSERT [dbo].[role_model] ([id], [role_id], [model_id]) VALUES (12, 1, 4)
INSERT [dbo].[role_model] ([id], [role_id], [model_id]) VALUES (13, 2, 4)
INSERT [dbo].[role_model] ([id], [role_id], [model_id]) VALUES (14, 3, 4)
INSERT [dbo].[role_model] ([id], [role_id], [model_id]) VALUES (15, 1, 5)
INSERT [dbo].[role_model] ([id], [role_id], [model_id]) VALUES (16, 2, 5)
INSERT [dbo].[role_model] ([id], [role_id], [model_id]) VALUES (17, 3, 5)
INSERT [dbo].[role_model] ([id], [role_id], [model_id]) VALUES (18, 4, 6)
INSERT [dbo].[role_model] ([id], [role_id], [model_id]) VALUES (19, 1, 7)
INSERT [dbo].[role_model] ([id], [role_id], [model_id]) VALUES (20, 2, 7)
INSERT [dbo].[role_model] ([id], [role_id], [model_id]) VALUES (21, 3, 7)
INSERT [dbo].[role_model] ([id], [role_id], [model_id]) VALUES (22, 4, 7)
INSERT [dbo].[role_model] ([id], [role_id], [model_id]) VALUES (23, 1, 8)
INSERT [dbo].[role_model] ([id], [role_id], [model_id]) VALUES (24, 1, 9)
INSERT [dbo].[role_model] ([id], [role_id], [model_id]) VALUES (25, 2, 9)
INSERT [dbo].[role_model] ([id], [role_id], [model_id]) VALUES (26, 1, 10)
INSERT [dbo].[role_model] ([id], [role_id], [model_id]) VALUES (27, 2, 10)
INSERT [dbo].[role_model] ([id], [role_id], [model_id]) VALUES (28, 1, 11)
INSERT [dbo].[role_model] ([id], [role_id], [model_id]) VALUES (29, 2, 11)
INSERT [dbo].[role_model] ([id], [role_id], [model_id]) VALUES (30, 1, 12)
INSERT [dbo].[role_model] ([id], [role_id], [model_id]) VALUES (31, 2, 12)
INSERT [dbo].[role_model] ([id], [role_id], [model_id]) VALUES (32, 1, 13)
INSERT [dbo].[role_model] ([id], [role_id], [model_id]) VALUES (33, 2, 13)
INSERT [dbo].[role_model] ([id], [role_id], [model_id]) VALUES (34, 1, 14)
INSERT [dbo].[role_model] ([id], [role_id], [model_id]) VALUES (35, 2, 14)
INSERT [dbo].[role_model] ([id], [role_id], [model_id]) VALUES (36, 1, 15)
INSERT [dbo].[role_model] ([id], [role_id], [model_id]) VALUES (37, 2, 15)
INSERT [dbo].[role_model] ([id], [role_id], [model_id]) VALUES (38, 1, 16)
INSERT [dbo].[role_model] ([id], [role_id], [model_id]) VALUES (39, 2, 16)
INSERT [dbo].[role_model] ([id], [role_id], [model_id]) VALUES (40, 1, 17)
INSERT [dbo].[role_model] ([id], [role_id], [model_id]) VALUES (41, 2, 17)
INSERT [dbo].[role_model] ([id], [role_id], [model_id]) VALUES (42, 1, 18)
INSERT [dbo].[role_model] ([id], [role_id], [model_id]) VALUES (43, 1, 19)
INSERT [dbo].[role_model] ([id], [role_id], [model_id]) VALUES (44, 1, 20)
INSERT [dbo].[role_model] ([id], [role_id], [model_id]) VALUES (45, 1, 21)
INSERT [dbo].[role_model] ([id], [role_id], [model_id]) VALUES (46, 2, 21)
INSERT [dbo].[role_model] ([id], [role_id], [model_id]) VALUES (47, 3, 21)
INSERT [dbo].[role_model] ([id], [role_id], [model_id]) VALUES (48, 1, 22)
INSERT [dbo].[role_model] ([id], [role_id], [model_id]) VALUES (49, 1, 23)
SET IDENTITY_INSERT [dbo].[role_model] OFF
SET IDENTITY_INSERT [dbo].[test] ON 


SET IDENTITY_INSERT [dbo].[test] OFF
SET IDENTITY_INSERT [dbo].[test_case] ON 


SET IDENTITY_INSERT [dbo].[test_case] OFF
SET IDENTITY_INSERT [dbo].[test_issue_type] ON 

INSERT [dbo].[test_issue_type] ([id], [name], [describe]) VALUES (1, N'无', N' ')
INSERT [dbo].[test_issue_type] ([id], [name], [describe]) VALUES (2, N'轻微', N'对软件的改进意见或者建议')
INSERT [dbo].[test_issue_type] ([id], [name], [describe]) VALUES (3, N'一般', N'使操作者不合理或者不方便或操作遇到麻烦，但它不影响执行工作功能或重要功能')
INSERT [dbo].[test_issue_type] ([id], [name], [describe]) VALUES (4, N'严重', N'规定的功能没有实现或不完整或产生错误结果；设计不合理造成性能低下，影响系统的运营；使系统不稳定、或破坏数据；而且是常规操作中经常发生或非常规操作中不可避免的主要问题')
INSERT [dbo].[test_issue_type] ([id], [name], [describe]) VALUES (5, N'致命', N'不能执行正常工作或重要功能，使系统崩溃或资源严重不足、数据丢失、死机等导致系统不能继续运行，必须马上修正')
SET IDENTITY_INSERT [dbo].[test_issue_type] OFF
SET IDENTITY_INSERT [dbo].[test_version] ON 


SET IDENTITY_INSERT [dbo].[test_version] OFF
SET IDENTITY_INSERT [dbo].[users] ON 

INSERT [dbo].[users] ([id], [name], [password], [email], [phone], [reg_datetime], [department], [role], [reg_status]) VALUES (1, N'admin', N'!#/)zWェC塉J€?', N'', N'', CAST(N'2018-01-01 00:00:00.000' AS DateTime), 1, 1, 2)
SET IDENTITY_INSERT [dbo].[users] OFF
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_department]    Script Date: 2018/7/20 9:27:35 ******/
ALTER TABLE [dbo].[department] ADD  CONSTRAINT [IX_department] UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_role]    Script Date: 2018/7/20 9:27:35 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_role] ON [dbo].[role]
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__test__72E12F1B2F0FA6DA]    Script Date: 2018/7/20 9:27:35 ******/
ALTER TABLE [dbo].[test] ADD  CONSTRAINT [UQ__test__72E12F1B2F0FA6DA] UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_test_issue_type]    Script Date: 2018/7/20 9:27:35 ******/
ALTER TABLE [dbo].[test_issue_type] ADD  CONSTRAINT [IX_test_issue_type] UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_users]    Script Date: 2018/7/20 9:27:35 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_users] ON [dbo].[users]
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[role_model]  WITH CHECK ADD  CONSTRAINT [FK_model_id] FOREIGN KEY([model_id])
REFERENCES [dbo].[model] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[role_model] CHECK CONSTRAINT [FK_model_id]
GO
ALTER TABLE [dbo].[role_model]  WITH CHECK ADD  CONSTRAINT [FK_role_id] FOREIGN KEY([role_id])
REFERENCES [dbo].[role] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[role_model] CHECK CONSTRAINT [FK_role_id]
GO
ALTER TABLE [dbo].[test]  WITH CHECK ADD  CONSTRAINT [FK_test_department] FOREIGN KEY([creation_department_id])
REFERENCES [dbo].[department] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[test] CHECK CONSTRAINT [FK_test_department]
GO
ALTER TABLE [dbo].[test]  WITH CHECK ADD  CONSTRAINT [FK_test_users] FOREIGN KEY([creation_user_id])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[test] CHECK CONSTRAINT [FK_test_users]
GO
ALTER TABLE [dbo].[test_case]  WITH CHECK ADD  CONSTRAINT [FK_test_case_pass] FOREIGN KEY([pass])
REFERENCES [dbo].[pass] ([id])
GO
ALTER TABLE [dbo].[test_case] CHECK CONSTRAINT [FK_test_case_pass]
GO
ALTER TABLE [dbo].[test_case]  WITH CHECK ADD  CONSTRAINT [FK_test_case_test_issue_type] FOREIGN KEY([type])
REFERENCES [dbo].[test_issue_type] ([id])
GO
ALTER TABLE [dbo].[test_case] CHECK CONSTRAINT [FK_test_case_test_issue_type]
GO
ALTER TABLE [dbo].[test_case]  WITH CHECK ADD  CONSTRAINT [FK_test_case_test_version] FOREIGN KEY([version_id])
REFERENCES [dbo].[test_version] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[test_case] CHECK CONSTRAINT [FK_test_case_test_version]
GO
ALTER TABLE [dbo].[test_case]  WITH CHECK ADD  CONSTRAINT [FK_test_case_users] FOREIGN KEY([creation_user_id])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[test_case] CHECK CONSTRAINT [FK_test_case_users]
GO
ALTER TABLE [dbo].[test_version]  WITH CHECK ADD  CONSTRAINT [FK_test_id] FOREIGN KEY([test_id])
REFERENCES [dbo].[test] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[test_version] CHECK CONSTRAINT [FK_test_id]
GO
ALTER TABLE [dbo].[users]  WITH CHECK ADD  CONSTRAINT [FK_users_department] FOREIGN KEY([department])
REFERENCES [dbo].[department] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[users] CHECK CONSTRAINT [FK_users_department]
GO
ALTER TABLE [dbo].[users]  WITH CHECK ADD  CONSTRAINT [FK_users_reg_status] FOREIGN KEY([reg_status])
REFERENCES [dbo].[reg_status] ([id])
GO
ALTER TABLE [dbo].[users] CHECK CONSTRAINT [FK_users_reg_status]
GO
ALTER TABLE [dbo].[users]  WITH CHECK ADD  CONSTRAINT [FK_users_role] FOREIGN KEY([role])
REFERENCES [dbo].[role] ([id])
GO
ALTER TABLE [dbo].[users] CHECK CONSTRAINT [FK_users_role]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'以当前日期生成的表单号 eg: 20180703091002' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'test_version', @level2type=N'COLUMN',@level2name=N'number'
GO
USE [master]
GO
ALTER DATABASE [STPlatform] SET  READ_WRITE 
GO
