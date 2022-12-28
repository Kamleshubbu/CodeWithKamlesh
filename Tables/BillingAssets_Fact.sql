USE [Dynasty_DW]
GO
/****** Object:  Table [dbo].[BillingAssets_Fact]    Script Date: 8/21/2019 2:03:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BillingAssets_Fact]') AND type in (N'U'))
BEGIN
		Print 'Creating BillingAssets_Fact table'
		CREATE TABLE [dbo].[BillingAssets_Fact](
			[InvestedDateIdNmb] [int] NOT NULL,
			[AsOfDateIdNmb] [int] NOT NULL,
			[InvestmentAccountIdNmb] [int]  NULL,
			[HouseholdIdNmb] [int]  NULL,
			[InvestmentAdvisorIdNmb] [int]  NULL,
			[CompanyIdNmb] [int] NOT NULL,
			[ManagerIDNmb] [int] NULL,
			[ProductIdNmb] [int] NULL,
			[PeriodStartDateIdNmb] [int] NULL,
			[PeriodEndDateIdNmb] [int] NULL,
			[BillableDays] [int] NULL,
			[PeriodDays] [int] NULL,
			[TypeIDNmb] [int]  NULL,
			[BillableAmount] [float]  NULL,
			[BillableHouseholdAmount] [float]  NULL,
			[ClientFeeAmount] [float]  NULL,
			[ClientFeePct] [float]  NULL,
			[AdvisorfeeAmount] [float]  NULL,
			[AdvisorFeePct] [float]  NULL,
			[ProgramfeeAmount] [float]  NULL,
			[Programfeepct] [float]  NULL,
			[ManagerFeeAmount] [float]  NULL,
			[ManagerFeePct] [float]  NULL,
			[FirmFeeAmount] [float]  NULL,
			[FirmFeePct] [float]  NULL,
			[DebitedAccount] [VARCHAR](50) NULL,
			[CustodianIdNmb] [int]  NULL,
			[CalculationTypeIdNmb] [INT] NULL,
			[BillingPeriod] [varchar](100) NULL,
			[BillingDate] [VARCHAR](100) NULL,
			[BillingRun] [varchar](100) NULL,
			[Timestamp]  [VARCHAR](100) NULL,
			[BillingSourceIdNmb] [INT] NULL,
			[CreateDate] [datetime] NOT NULL ,
			[Idnmb] [int] IDENTITY(1,1) NOT NULL,
		 CONSTRAINT [PK_BillingAssets_Fact] PRIMARY KEY CLUSTERED 
		(
			[Idnmb] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
		) ON [PRIMARY]
		Print 'Created BillingAssets_Fact table Successfully'
END
Else
	Begin
	
		Print 'Updating BillingAssets_Fact structure'
		
		IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF_BillingAssets_Fact_CreateDate]') AND type = 'D')
		BEGIN
				ALTER TABLE [dbo].[BillingAssets_Fact] ADD  CONSTRAINT [DF_BillingAssets_Fact_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
		END

		IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BillingAssets_Fact' AND COLUMN_NAME = 'TIMESTAMP')
		Begin
				Alter table BillingAssets_Fact add TIMESTAMP [VARCHAR](50) NULL
				Print 'Added TIMESTAMP Column'
		End

		IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BillingAssets_Fact' AND COLUMN_NAME = 'BillingSourceIdNmb')
		Begin
				Alter table BillingAssets_Fact add BillingSourceIdNmb INT  NULL
				Print 'Added BillingSourceIdNmb Column'
		End

		
		IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BillingAssets_Fact' AND COLUMN_NAME = 'BillingGroupName')
		Begin
				Alter table BillingAssets_Fact add BillingGroupName [VARCHAR](500) NULL
				Print 'Added BillingGroupName Column'
		End


		IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BillingAssets_Fact' AND COLUMN_NAME = 'BranchName')
		Begin
				Alter table BillingAssets_Fact add BranchName [VARCHAR](500) NULL
				Print 'Added BranchName Column'
		End


		IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BillingAssets_Fact' AND COLUMN_NAME = 'CustomerRepCode')
		Begin
				Alter table BillingAssets_Fact add CustomerRepCode [VARCHAR](500) NULL
				Print 'Added CustomerRepCode Column'
		End


		IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BillingAssets_Fact' AND COLUMN_NAME = 'AdvisorNum')
		Begin
				Alter table BillingAssets_Fact add AdvisorNum [VARCHAR](500) NULL
				Print 'Added AdvisorNum Column'
		End


		IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BillingAssets_Fact' AND COLUMN_NAME = 'Product')
		Begin
				Alter table BillingAssets_Fact add Product [VARCHAR](500) NULL
				Print 'Added Product Column'
		End


		IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BillingAssets_Fact' AND COLUMN_NAME = 'ProductTier')
		Begin
				Alter table BillingAssets_Fact add ProductTier [VARCHAR](500) NULL
				Print 'Added ProductTier Column'
		End

	

		IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BillingAssets_Fact' AND COLUMN_NAME = 'AccounttotalAmount')
		Begin
				Alter table BillingAssets_Fact add AccounttotalAmount FLOAT NULL
				Print 'Added AccounttotalAmount Column'
		End	
		
		
		IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BillingAssets_Fact' AND COLUMN_NAME = 'CustodyFeeAmount')
		Begin
				Alter table BillingAssets_Fact add CustodyFeeAmount FLOAT NULL
				Print 'Added CustodyFeeAmount Column'
		End

		
		IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BillingAssets_Fact' AND COLUMN_NAME = 'CustodyFeePct')
		Begin
				Alter table BillingAssets_Fact add CustodyFeePct FLOAT NULL
				Print 'Added CustodyFeePct Column'
		End

		
		IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BillingAssets_Fact' AND COLUMN_NAME = 'GroupAccounts')
		Begin
				Alter table BillingAssets_Fact add GroupAccounts [VARCHAR](500) NULL
				Print 'Added GroupAccounts Column'
		End

		
		IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BillingAssets_Fact' AND COLUMN_NAME = 'BillingLevel')
		Begin
				Alter table BillingAssets_Fact add BillingLevel [VARCHAR](500) NULL
				Print 'Added BillingLevel Column'
		End

		
		IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BillingAssets_Fact' AND COLUMN_NAME = 'FCDAFDistribute')
		Begin
				Alter table BillingAssets_Fact add FCDAFDistribute [VARCHAR](500) NULL
				Print 'Added FCDAFDistribute Column'
		End

		
		IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BillingAssets_Fact' AND COLUMN_NAME = 'BillingMode')
		Begin
				Alter table BillingAssets_Fact add BillingMode [VARCHAR](500) NULL
				Print 'Added BillingMode Column'
		End

		
		IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BillingAssets_Fact' AND COLUMN_NAME = 'AdvisorFeeExcludedAmount')
		Begin
				Alter table BillingAssets_Fact add AdvisorFeeExcludedAmount FLOAT NULL
				Print 'Added AdvisorFeeExcludedAmount Column'
		End

		
		IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BillingAssets_Fact' AND COLUMN_NAME = 'ClientFeeExcludedAmount')
		Begin
				Alter table BillingAssets_Fact add ClientFeeExcludedAmount FLOAT NULL
				Print 'Added ClientFeeExcludedAmount Column'
		End

		
		IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BillingAssets_Fact' AND COLUMN_NAME = 'FirmHouseholdAmount')
		Begin
				Alter table BillingAssets_Fact add FirmHouseholdAmount FLOAT NULL
				Print 'Added FirmHouseholdAmount Column'
		End

		
		IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BillingAssets_Fact' AND COLUMN_NAME = 'SponsorHouseholdAmount')
		Begin
				Alter table BillingAssets_Fact add SponsorHouseholdAmount FLOAT NULL
				Print 'Added SponsorHouseholdAmount Column'
		End

		
		IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BillingAssets_Fact' AND COLUMN_NAME = 'ManagerHouseholdAmount')
		Begin
				Alter table BillingAssets_Fact add ManagerHouseholdAmount FLOAT NULL
				Print 'Added ManagerHouseholdAmount Column'
		End

		
		IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BillingAssets_Fact' AND COLUMN_NAME = 'CustodyHouseholdAmount')
		Begin
				Alter table BillingAssets_Fact add CustodyHouseholdAmount FLOAT  NULL
				Print 'Added CustodyHouseholdAmount Column'
		End


		IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BillingAssets_Fact' AND COLUMN_NAME = 'AdvisorHouseholdAmount')
		Begin
				Alter table BillingAssets_Fact add AdvisorHouseholdAmount FLOAT NULL
				Print 'Added AdvisorHouseholdAmount Column'
		End

		IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BillingAssets_Fact' AND COLUMN_NAME = 'ClientHouseholdAmount')
		Begin
				Alter table BillingAssets_Fact add ClientHouseholdAmount FLOAT NULL
				Print 'Added ClientHouseholdAmount Column'
		End

		IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BillingAssets_Fact' AND COLUMN_NAME = 'BillingHistory')
		Begin
				Alter table BillingAssets_Fact add BillingHistory [VARCHAR](500) NULL
				Print 'Added BillingHistory Column'
		End

		IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BillingAssets_Fact' AND COLUMN_NAME = 'AccountId')
		Begin
				Alter table BillingAssets_Fact add AccountId [VARCHAR](500) NULL
				Print 'Added AccountId Column'
		End

		IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BillingAssets_Fact' AND COLUMN_NAME = 'AccountDescription')
		Begin
				Alter table BillingAssets_Fact add AccountDescription [VARCHAR](500) NULL
				Print 'Added AccountDescription Column'
		End

		IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BillingAssets_Fact' AND COLUMN_NAME = 'CustomerRepCodeDesc')
		Begin
				Alter table BillingAssets_Fact add CustomerRepCodeDesc [VARCHAR](500) NULL
				Print 'Added CustomerRepCodeDesc Column'
		End

		IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BillingAssets_Fact' AND COLUMN_NAME = 'CustomServiceFeeAmount')
		Begin
				Alter table BillingAssets_Fact add CustomServiceFeeAmount FLOAT NULL
				Print 'Added CustomServiceFeeAmount Column'
		End

			
		IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BillingAssets_Fact' AND COLUMN_NAME = 'CustomServiceFeePct')
		Begin
				Alter table BillingAssets_Fact add CustomServiceFeePct FLOAT NULL
				Print 'Added CustomServiceFee Column'
		End
			
		IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BillingAssets_Fact' AND COLUMN_NAME = 'CustomServiceDistributeFeeAmount')
		Begin
				Alter table BillingAssets_Fact add CustomServiceDistributeFeeAmount FLOAT NULL
				Print 'Added CustomServiceDistributeFeeAmount Column'
		End

				
		IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BillingAssets_Fact' AND COLUMN_NAME = 'CustomServiceDistributeFeePct')
		Begin
				Alter table BillingAssets_Fact add CustomServiceDistributeFeePct FLOAT NULL
				Print 'Added CustomServiceDistributeFeePct Column'
		End

			
		IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BillingAssets_Fact' AND COLUMN_NAME = 'DerivedComponent')
		Begin
				Alter table BillingAssets_Fact add DerivedComponent [VARCHAR](500) NULL
				Print 'Added DerivedComponent Column'
		End

		IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BillingAssets_Fact' AND COLUMN_NAME = 'BatchName')
		Begin
				Alter table BillingAssets_Fact add BatchName [VARCHAR](500) NULL
				Print 'Added BatchName Column'
		End

		IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BillingAssets_Fact' AND COLUMN_NAME = 'PlatformFee')
		Begin
				Alter table BillingAssets_Fact add PlatformFee FLOAT NULL
				Print 'Added PlatformFee Column'
		End


		IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BillingAssets_Fact' AND COLUMN_NAME = 'PlatformFeePct')
		Begin
				Alter table BillingAssets_Fact add PlatformFeePct FLOAT NULL
				Print 'Added PlatformFeePct Column'
		End

		IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BillingAssets_Fact' AND COLUMN_NAME = 'SponsorFee')
		Begin
				Alter table BillingAssets_Fact add SponsorFee FLOAT NULL
				Print 'Added SponsorFee Column'
		End

		IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BillingAssets_Fact' AND COLUMN_NAME = 'SponsorFeePct')
		Begin
				Alter table BillingAssets_Fact add SponsorFeePct FLoat NULL
				Print 'Added SponsorFeePct Column'
		End


		IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BillingAssets_Fact' AND COLUMN_NAME = 'ProductGroup')
		Begin
				Alter table BillingAssets_Fact add ProductGroup [VARCHAR](500) NULL
				Print 'Added ProductGroup Column'
		End

		
		IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BillingAssets_Fact' AND COLUMN_NAME = 'AdvisoryRevenue')
		Begin
				Alter table BillingAssets_Fact add AdvisoryRevenue FLOAT NULL
				Print 'Added AdvisoryRevenue Column'
		End

		
		IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BillingAssets_Fact' AND COLUMN_NAME = 'COSAdvisory')
		Begin
				Alter table BillingAssets_Fact add COSAdvisory [VARCHAR](500) NULL
				Print 'Added COSAdvisory Column'
		End

		
		IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BillingAssets_Fact' AND COLUMN_NAME = 'COSTAMP')
		Begin
				Alter table BillingAssets_Fact add COSTAMP [VARCHAR](500) NULL
				Print 'Added COSTAMP Column'
		End

		IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BillingAssets_Fact' AND COLUMN_NAME = 'PaymentDate')
		Begin
				Alter table BillingAssets_Fact add PaymentDate Date NULL
				Print 'Added PaymentDate Column'
		End

		IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BillingAssets_Fact' AND COLUMN_NAME = 'ProductGroupIdnmb')
		Begin
				Alter table BillingAssets_Fact add ProductGroupIdnmb INT NULL
				Print 'Added ProductGroupIdnmb Column'
		End

		IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BillingAssets_Fact' AND COLUMN_NAME = 'AssetTypeIdnmb')
		Begin
				Alter table BillingAssets_Fact add AssetTypeIdnmb INT NULL
				Print 'Added AssetTypeIdnmb Column'
		End

		IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BillingAssets_Fact' AND COLUMN_NAME = 'BillDate')
		Begin
				Alter table BillingAssets_Fact add BillDate DATE NULL
				Print 'Added BillDate Column'
		End

		IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BillingAssets_Fact' AND COLUMN_NAME = 'Strategyidnmb')
		Begin
				Alter table BillingAssets_Fact add Strategyidnmb INT NULL
				Print 'Added Strategyidnmb Column'
		End



	END
GO
