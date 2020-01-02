USE [ClinicPro]
GO

/****** Object:  View [dbo].[VClinicInvoice]    Script Date: 06-Nov-2019 9:28:08 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


ALTER VIEW [dbo].[VClinicInvoice]
AS
SELECT     dbo.Invoice.ClinicID, dbo.Clinics.Clinic, dbo.Invoice.InvoiceID, dbo.Invoice.InvoiceDate, dbo.Invoice.TotalAmount, dbo.Patients.Code, dbo.Patients.Name, 
                      dbo.FeeCategory.Category, dbo.Invoice.NetAmount, dbo.Invoice.PaidAmount, dbo.Invoice.RemAmount, dbo.Invoice.Cash, dbo.Invoice.Discount, 
                      dbo.Invoice.DiscPercentage, dbo.FeeCategory.CategoryID, dbo.Invoice.DoctorID, dbo.Doctors.Name AS Doctor, dbo.Invoice.Del, dbo.Invoice.CreditAmount, 
                      dbo.Invoice.SubCategoryID, dbo.Invoice.FeeGroupID, dbo.Doctors.BranchID, dbo.Patients.Company,dbo.Invoice.VAT,
					  (select  sum(invoicedetail.BadDebit+BadDebitVAT) from invoicedetail where invoicedetail.invoiceid=dbo.Invoice.InvoiceID) as [Bad Debit With Vat]
 ,(dbo.Invoice.RemAmount- (select  sum(coalesce(invoicedetail.BadDebit,0)+coalesce(BadDebitVAT,0)) from invoicedetail where invoicedetail.invoiceid=dbo.Invoice.InvoiceID)) as 'Balance'
FROM         dbo.Invoice INNER JOIN
                      dbo.Clinics ON dbo.Invoice.ClinicID = dbo.Clinics.CinicID INNER JOIN
                      dbo.Patients ON dbo.Invoice.PatientID = dbo.Patients.PatientID INNER JOIN
                      dbo.FeeCategory ON dbo.Invoice.Type = dbo.FeeCategory.CategoryID INNER JOIN
                      dbo.Doctors ON dbo.Invoice.DoctorID = dbo.Doctors.DoctorID


GO


