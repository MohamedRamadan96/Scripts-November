USE [ClinicPro]
GO

/****** Object:  StoredProcedure [dbo].[SP_Rpt_InsurancePaymenDetailsByInvDate]    Script Date: 10/23/2019 10:34:27 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





-- =============================================
-- Author:		Mostafa Safwat
-- Create date: 17-01-2018
-- Description:	Used to get Data for Report InsurancePaymenDetailsByInvDate No. 64 to Export to Excel
-- =============================================
ALTER PROCEDURE [dbo].[SP_Rpt_InsurancePaymenDetailsByInvDate](
@StDate nvarchar(50)
,@EndDate nvarchar(50)
,@CategoryID nvarchar(4)
,@DoctorID nvarchar(4)
,@FeeGroupID nvarchar(1)
,@branchID int
)

	-- Add the parameters for the stored procedure here
	
AS
BEGIN

	SET NOCOUNT ON;

  
SELECT     dbo.Invoice.PatientID,dbo.Patients.InsuranceCardID as [Member ID], dbo.Patients.Name AS Patient, dbo.Invoice.InvoiceID, dbo.Invoice.InvoiceDate, dbo.FeeCategory.Category,EclaimInvoice.TransactionDate  as [Submitted Date], dbo.Doctors.Name AS Doctor, 
                      dbo.InvoiceDetail.TotalGross, dbo.InvoiceDetail.TotalNet, dbo.InvoiceDetail.CreditAmt,
					   dbo.InvoiceDetail.Description, dbo.InvoiceDetail.Cash, dbo.Invoice.Notes, dbo.Invoice.ResubmitNotes,
                      dbo.InvoiceDetail.Code,   dbo.InvoiceDetail.InsPaid
                      AS PaymentAmount,(dbo.InvoiceDetail.CreditAmt-dbo.InvoiceDetail.InsPaid) as
					   [RemAmount],[CashDisc], dbo.InvoiceDetail.Qty
, dbo.InvoiceDetail.DenialCode, dbo.Invoice.PaymentReference,(select top 1 InvoiceRemitanceDetail.DateSettlement from InvoiceRemitanceDetail  where InvoiceNo=Invoice.InvoiceID order by DateSettlement desc) as [payment Date],

datediff(day,(select top 1 InvoiceRemitanceDetail.DateSettlement from InvoiceRemitanceDetail  where InvoiceNo=Invoice.InvoiceID order by DateSettlement desc),GetDate()) as [Day Left]
FROM         dbo.InvoiceDetail INNER JOIN
                      dbo.Patients INNER JOIN
                      dbo.Doctors INNER JOIN
                      dbo.FeeCategory INNER JOIN
                      dbo.Invoice ON dbo.FeeCategory.CategoryID = dbo.Invoice.Type ON dbo.Doctors.DoctorID = dbo.Invoice.DoctorID ON dbo.Patients.PatientID = dbo.Invoice.PatientID ON
                       dbo.InvoiceDetail.InvoiceID = dbo.Invoice.InvoiceID


					   left outer join EclaimInvoice  on  dbo.Invoice.invoiceid=EclaimInvoice.EclaimInvoiceID
WHERE dbo.Invoice.Del= 0 AND dbo.Invoice.InvoiceDate between @StDate and @EndDate
AND  (dbo.FeeCategory.CategoryID = @CategoryID OR @CategoryID = 0 )
AND (Invoice.DoctorID = @DoctorID OR @DoctorID = 0)
AND (FeeGroupID = @FeeGroupID OR @FeeGroupID =0 )
AND Doctors.BranchID = @branchID

END






GO


