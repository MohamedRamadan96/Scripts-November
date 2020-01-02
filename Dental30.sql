USE [ClinicPro]
GO

INSERT INTO [dbo].[Fees]
           ([Code]
           ,[Description]
           ,[Amount]
           ,[NetPrice]
           ,[Clinic]
           ,[LastUpdated]
           ,[UpdatedBy]
           ,[CategoryID]
           ,[FeeGroupID]
           ,[FeeServiceTypeID]
           ,[ShortDesc]
           ,[ColOrder]
           ,[Cost]
           ,[BranchID]
           ,[NetworkID]
           ,[VAT]
           ,[Loyalty])
Select
			[USCLS CODE]
			,[SERVICE DESCRIPTION]
			,[Gross Price]
			,[Net Price]
			,3
			,GETDATE()
			,1
			,6
			,1
			,6
			,SUBSTRING([SERVICE DESCRIPTION],0,50)
			,100000
			,0
			,3
			,NULL
			,0
			,0
			From [ClinicProBK].[dbo].[Dental Nass Tarif]
GO


