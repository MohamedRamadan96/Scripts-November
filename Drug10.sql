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
		   [Drug Code]
		  ,[Package Name]
	      ,[Unit Price to Public]
		  ,[Unit Price to Public]-([Unit Price to Public]*10/100)
		  ,0
		  ,getdate()
		  ,1
		  ,6
		  ,1
		  ,5
		  ,substring([Package Name],0,50)
		  ,100000
		  ,0
		  ,3
		  ,null
		  ,0
		  ,0
		From [ClinicProBk].[dbo].[Drugs-Sep] 
go
