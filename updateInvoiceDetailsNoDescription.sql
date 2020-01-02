update InvoiceDetail set Description = [ClinicProBK].[dbo].[Mandatory Tariff 2012-Q2].[Code Description] from InvoiceDetail
inner join [ClinicProBK].[dbo].[Mandatory Tariff 2012-Q2]
on [ClinicProBK].[dbo].[Mandatory Tariff 2012-Q2].[Code] collate Arabic_CI_AS = InvoiceDetail.Code collate Arabic_CI_AS
where InvoiceDetail.Description is null or InvoiceDetail.Description = ' ' 



update InvoiceDetail set Description = Fees.Description from InvoiceDetail
inner join Fees
on Fees.[Code] collate Arabic_CI_AS = InvoiceDetail.Code collate Arabic_CI_AS
where  InvoiceDetail.Description = '&nbsp;' and Fees.Description <>'&nbsp;'








