USE [ClinicPro]
GO

/****** Object:  StoredProcedure [dbo].[SpR_InsuranceResubmisionReport]    Script Date: 10/24/2019 11:38:16 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Create PROCEDURE [dbo].[SpR_InsuranceResubmisionReportByInvoiceDate]
 @StDate nvarchar(50)
,@EndDate nvarchar(50)
,@CategoryID nvarchar(4)
,@DoctorID nvarchar(4)
,@BranchID  int
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here


SELECT     dbo.Invoice.PatientID, dbo.Patients.Name AS Patient, dbo.Invoice.InvoiceID, dbo.Invoice.InvoiceDate
,dbo.Invoice.ResubmitDate,
 dbo.FeeCategory.Category, dbo.Doctors.Name AS Doctor, 
                      dbo.Invoice.TotalAmount AS TotalGross, dbo.Invoice.NetAmount AS TotalNet,
					   dbo.Invoice.CreditAmount AS CreditAmt, dbo.Invoice.Cash, dbo.Invoice.Notes,
                        dbo.Invoice.CreditAmount-  (SELECT     SUM(PaymentAmount) AS PaymentAmount
                            FROM          dbo.InvoiceRemitanceDetail
                            WHERE      (InvoiceNo = dbo.Invoice.InvoiceID) and dbo.InvoiceRemitanceDetail.PaymentDate<dbo.Invoice.ResubmitDate) AS ResubmittedAmount,
							 dbo.Invoice.InsCompanyRef, dbo.Invoice.CardID, dbo.Invoice.ResubmitNotes, 
                      dbo.Invoice.Del
FROM         dbo.Invoice INNER JOIN
                      dbo.Patients ON dbo.Invoice.PatientID = dbo.Patients.PatientID INNER JOIN
                      dbo.Doctors ON dbo.Invoice.DoctorID = dbo.Doctors.DoctorID INNER JOIN
                      dbo.FeeCategory ON dbo.Invoice.Type = dbo.FeeCategory.CategoryID
WHERE dbo.Invoice.Del= 0 AND dbo.Invoice.InvoiceDate between @StDate and @EndDate
and dbo.Invoice.ResubmitDate is not null
AND (dbo.FeeCategory.CategoryID=@CategoryID OR @CategoryID = 0)
and dbo.Doctors.BranchID=@BranchID
AND (Invoice.DoctorID= @DoctorID OR @DoctorID = 0)


END
GO


