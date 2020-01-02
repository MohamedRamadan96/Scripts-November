USE [ClinicPro]
GO

/****** Object:  StoredProcedure [dbo].[SpR_InsuranceResubmisionReport]    Script Date: 10/24/2019 11:42:20 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[SpR_InsuranceResubmisionReport]
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



SELECT    dbo.Patients.Name AS Patient, dbo.Invoice.InvoiceID as [Invoice No], 
dbo.Invoice.InvoiceDate as [Service Date],dbo.Invoice.InsCompanyRef as [Payment Ref.No], dbo.Invoice.CreditAmount AS [Claimed Amt], dbo.Invoice.Cash as [Copay]
,   (SELECT     SUM(PaymentAmount) AS PaymentAmount
                            FROM          dbo.InvoiceRemitanceDetail
                            WHERE      (InvoiceNo = dbo.Invoice.InvoiceID)) AS [Paid Amount],
							( dbo.Invoice.CreditAmount - (SELECT     SUM(PaymentAmount) AS PaymentAmount
                            FROM          dbo.InvoiceRemitanceDetail
                            WHERE      (InvoiceNo = dbo.Invoice.InvoiceID))) as [Rejected Amount],
															( dbo.Invoice.CreditAmount - (SELECT     SUM(PaymentAmount) AS PaymentAmount
                            FROM          dbo.InvoiceRemitanceDetail
                            WHERE      (InvoiceNo = dbo.Invoice.InvoiceID))) as [Resubmitted Amount], dbo.Invoice.ResubmitNotes as [Reason of Resubmission]
							,dbo.Invoice.ResubmitDate,
               dbo.Invoice.ResubmissionTries as [Resub Trials]
                   
FROM         dbo.Invoice INNER JOIN
                      dbo.Patients ON dbo.Invoice.PatientID = dbo.Patients.PatientID INNER JOIN
                      dbo.Doctors ON dbo.Invoice.DoctorID = dbo.Doctors.DoctorID INNER JOIN
                      dbo.FeeCategory ON dbo.Invoice.Type = dbo.FeeCategory.CategoryID
WHERE dbo.Invoice.Del= 0 AND dbo.Invoice.ResubmitDate between @StDate and @EndDate
and dbo.Invoice.ResubmitDate is not null
and dbo.Doctors.BranchID=@BranchID
AND (dbo.FeeCategory.CategoryID=@CategoryID OR @CategoryID = 0)
AND (Invoice.DoctorID= @DoctorID OR @DoctorID = 0)
AND        ((SELECT     SUM(PaymentAmount) AS PaymentAmount
                              FROM         dbo.InvoiceRemitanceDetail AS InvoiceRemitanceDetail_1
                              WHERE     (dbo.Invoice.InvoiceID = InvoiceNo)) < CreditAmount) 

END


GO


