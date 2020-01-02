


INSERT INTO [dbo].[Drugs]
           ([Code]
           ,[ProductName]
           ,[PackageName]
           ,[GenericName]
           ,[Strength]
           ,[DosageForm]
           ,[PackageSize]
           ,[PackagePrice]
           ,[Status]
           ,[LastChange]
		   ,[ManufacturerName]
           ,[AgentName]
           ,[UnitPricePublic]
          )
    SELECT 
	   [Drug Code]
      ,[Package Name]
      ,[Package Name]
      ,[Generic Name]
      ,[Strength]
      ,[Dosage Form]

      ,[Package Size]
	    ,[Package Price to Public]
		,[Status]
		,[Last Change Date]
		
      ,[Manufacturer Name]
       ,[Agent Name]
      ,[Unit Price to Public]
      
      
     
  FROM [ClinicProBak].[dbo].[Drugs-Sep]     where [ClinicProBak].[dbo].[Drugs-Sep] .[Drug Code] collate Arabic_CI_AS not in
  (select [Code] collate Arabic_CI_AS from [dbo].[Drugs])
GO



Mohamedramadan13111996@gmail.com
Segmentation96