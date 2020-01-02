USE [ClinicPro]

GO

/****** Object:  StoredProcedure [dbo].[SP_GetInvoice_ByInvoiceID]    Script Date: 11/12/2019 10:40:30 ******/

SET ANSI_NULLS ON

GO

SET QUOTED_IDENTIFIER ON

GO

 

 

 

 

 

-- =============================================

-- Author:        Mostafa Safwat

-- Create date: 28-May-2011

--Modified Date :30-9-2012

-- Description:   This Function is used to get invoice detail and used in Invoice Edit Screen

-- =============================================

ALTER PROCEDURE [dbo].[SP_GetInvoice_ByInvoiceID](@InvoiceID int)

 

AS

BEGIN

      -- SET NOCOUNT ON added to prevent extra result sets from

      -- interfering with SELECT statements.

      SET NOCOUNT ON;

 

    -- Insert statements for procedure here

      SELECT     dbo.Invoice.InvoiceID, dbo.Invoice.InvoiceDate, dbo.Invoice.TreatmentID, Invoice.PatientID, Invoice.DoctorID,

                                Invoice.ClinicID, dbo.Invoice.TotalAmount, dbo.Invoice.Paied,

                                dbo.Invoice.PaidAmount, dbo.Invoice.RemAmount, dbo.Invoice.Discount, dbo.Invoice.NetAmount, dbo.Invoice.VisitID, dbo.Invoice.[Type],

                      dbo.Invoice.FeeGroupID, dbo.Invoice.DiscPercentage, dbo.Invoice.CreditAmount, dbo.Invoice.SubCategoryID,

                      dbo.Invoice.Notes, dbo.Invoice.Cash, Invoice.CashDisc, dbo.Invoice.PC, dbo.Invoice.GP, dbo.Invoice.PH, dbo.Invoice.DN,

                      dbo.Invoice.DNCash, dbo.Invoice.CoPay, dbo.Invoice.CoPayPlus, dbo.Invoice.CoPayCash, dbo.Invoice.Ded,

                      dbo.Invoice.DedPlus, dbo.Invoice.MaxCash,

                      dbo.Invoice.Product, dbo.Invoice.CardID, dbo.Invoice.CardExp, dbo.Invoice.StartAuth, dbo.Invoice.EndAuth,

                      dbo.Invoice.MaxCoPay, dbo.Invoice.GPPer, dbo.Invoice.GPMax, WaitingPatient.Patient ,

                      dbo.Invoice.Lab, dbo.Invoice.LabCash, dbo.Invoice.Xray, dbo.Invoice.XrayCash, dbo.Invoice.DNMax,

                      dbo.Invoice.MaxDNCredit, dbo.Invoice.NetworkID , dbo.Invoice.OrderDoctor, dbo.Invoice.ManualCash,

                      dbo.Invoice.VAT, dbo.Invoice.RemAmount , WaitingPatient.VisitStatusID , WaitingPatient.VisitComment ,

                                Patients.InsuranceCompany , Patients.CardImg, Patients.CardImgBack , dbo.FunFormatDateTimeString(WaitingPatient.ArrDate) AS  ArrDate

                                ,  dbo.FunFormatDateTimeString(WaitingPatient.NurseSeenTime) AS  NurseSeenTime

                                     ,  dbo.FunFormatDateTimeString(WaitingPatient.DoctorSeenTime) AS  DoctorSeenTime

                               , dbo.FunFormatDateTimeString(WaitingPatient.EndDate) AS  EndDate   , Invoice.Approved  ,Invoice.Type AS CatgeoryID             

FROM         dbo.Invoice INNER JOIN WaitingPatient On Invoice.VisitID = WaitingPatient.WaitingID

                  INNER JOIN Patients On Patients.PatientID = dbo.WaitingPatient.PatientID

      WHERE InvoiceID = @InvoiceID

END

 

 

 

 

 

 

