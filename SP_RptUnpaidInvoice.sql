USE [ClinicPro]
GO

/****** Object:  StoredProcedure [dbo].[SP_RptUnpaidInvoice]    Script Date: 05-Nov-2019 11:09:46 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[SP_RptUnpaidInvoice]
	-- Add the parameters for the stored procedure here
 @StDate nvarchar(50)
,@EndDate nvarchar(50)
,@CategoryID nvarchar(4)
,@DoctorID nvarchar(4)
,@ClinicID  nvarchar(4)
,@FeeGroupID nvarchar(1)
,@BranchID  int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
 SELECT VClinicInvoice.Category,VClinicInvoice.Clinic,VClinicInvoice.Doctor, VClinicInvoice.InvoiceID, VClinicInvoice.Code,
 VClinicInvoice.Name,VClinicInvoice.InvoiceDate,VClinicInvoice.NetAmount, VClinicInvoice.VAT as [Vat Amount],
(VClinicInvoice.NetAmount+VClinicInvoice.VAT) as [Total With Vat],
 VClinicInvoice.Cash,VClinicInvoice.PaidAmount, 
 (select  sum(invoicedetail.BadDebit+BadDebitVAT) from invoicedetail where invoicedetail.invoiceid=VClinicInvoice.InvoiceID) as [Bad Debit With Vat]
 ,(VClinicInvoice.RemAmount- (select  sum(coalesce(invoicedetail.BadDebit,0)+coalesce(BadDebitVAT,0)) from invoicedetail where invoicedetail.invoiceid=VClinicInvoice.InvoiceID)) as 'Balance'
  
 FROM   ClinicPro.dbo.VClinicInvoice 


WHERE VClinicInvoice.InvoiceDate between @StDate and @EndDate
AND  (VClinicInvoice.CategoryID = @CategoryID OR @CategoryID = 0 )
AND (VClinicInvoice.DoctorID = @DoctorID OR @DoctorID = 0)
AND (VClinicInvoice.ClinicID = @ClinicID OR @ClinicID = 0)
AND (VClinicInvoice.FeeGroupID= @FeeGroupID or @FeeGroupID=0)
AND (VClinicInvoice.BranchID= @BranchID)
And VClinicInvoice.del=0
and VClinicInvoice.RemAmount > 0

 ORDER BY VClinicInvoice.Clinic, VClinicInvoice.Doctor, VClinicInvoice.Category






END


GO
update reportmaster set spname='SP_RptUnpaidInvoice' where reportid=9
Go

