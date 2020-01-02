-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SpR_RemittanceAdvicePerMonthRpt_InvoiceDate]
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
	SELECT    FeeCategory.Category,
        substring(convert(nvarchar(20),Invoice.invoiceDate,106),4,3)+ ' ' +
           substring(convert(nvarchar(20),Invoice.invoiceDate,106),8,4)  as monthNo,
		   sum(InvoiceRemitanceDetail.PaymentAmount) as MonthAmount,InvoiceRemitanceDetail.PaymentReference,InvoiceRemitanceDetail.PaymentDate
			FROM         InvoiceRemitanceDetail INNER JOIN
                      Invoice ON InvoiceRemitanceDetail.InvoiceNo = Invoice.InvoiceID INNER JOIN
                      FeeCategory ON Invoice.Type = FeeCategory.CategoryID
						inner join dbo.Doctors on dbo.Doctors.DoctorID=Invoice.DoctorID


				where 
				InvoiceRemitanceDetail.PaymentDate between @StDate and @EndDate
				AND Convert(nvarchar(5),dbo.FeeCategory.CategoryID) like @CategoryID
				And dbo.Doctors.BranchID=@BranchID

				group by  FeeCategory.Category,      substring(convert(nvarchar(20),Invoice.invoiceDate,106),4,3)+ ' ' +
						   substring(convert(nvarchar(20),Invoice.invoiceDate,106),8,4),InvoiceRemitanceDetail.PaymentReference,FeeCategory.Category,
				InvoiceRemitanceDetail.PaymentDate

				order by FeeCategory.Category,InvoiceRemitanceDetail.PaymentReference,InvoiceRemitanceDetail.PaymentDate asc

END
GO
