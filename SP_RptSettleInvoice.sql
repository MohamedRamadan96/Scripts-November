USE [ClinicPro]
GO
/****** Object:  StoredProcedure [dbo].[SP_RptHTransactionsAll]    Script Date: 11/28/2019 1:15:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Create PROCEDURE [dbo].[SP_RptSettleInvoice]
	-- Add the parameters for the stored procedure here
 @StDate nvarchar(50)
,@EndDate nvarchar(50)
,@BranchID  int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	
	
select waitingpatient.PatientID as FileNo , WaitingPatient.WaitingID as VisitNo , Invoice.InvoiceID as InvoiceNo , 
patients.Name  as PatientName , doctors.Name as DoctorName ,  Users.username as SettleInvoice , LastUser.UserName as LastEditInvoice

from INVOICE inner join Patients on Invoice.PatientID = Patients.PatientID 
		     inner join Doctors on Invoice.DoctorID = doctors.DoctorID 
			 inner join WaitingPatient on Invoice.VisitID = WaitingPatient.WaitingID 
			 inner join InvoiceHistory on (Invoice.InvoiceID = InvoiceHistory.InvoiceID and InvoiceHistory.action='Inserted')
			 inner join Users on InvoiceHistory.UpdatedBy = Users.UserID
			 inner join users As LastUser on  Invoice.UpdatedBy = LastUser.UserID
			 
			 

where 
    INVOICE.invoicedate between @StDate and @EndDate
   and doctors.BranchID=@BranchID
 
END
