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
    SELECT 
      [Code]
      ,[Code Description]
      ,[Field4]
	  ,[Field4]
	  ,0
	  ,GETDATE()
	  ,1
	  ,6
	  ,1
	  ,3
	  ,SUBSTRING([Code Description],0,50)
	  ,100000
	  ,0
	  ,3
	  ,null
	  ,0
	  ,0

  FROM [ClinicProBK].[dbo].[Mandatory Tariff 2012-Q2] where [Type] = 'CPT' and [Field4] is not null 
GO

