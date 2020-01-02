USE [ClinicPro]
GO
/****** Object:  Trigger [dbo].[WaitingPatientInsertHistory]    Script Date: 11/28/2019 10:40:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[InsertCategoryID_InCaseOfNUll] 

ON [dbo].[WaitingPatient]
after INSERT
AS
BEGIN

declare @PatientID int, @CategoryID int , @NewCategoryID int,@waitingid int


select @PatientID=PatientID,@CategoryID=CategoryID,@waitingid=waitingid  from inserted


if(@CategoryID is null)

Begin
	select @NewCategoryID =InsuranceCompany from patients where patientid=@PatientID

	update WaitingPatient   set CategoryID=coalesce(@NewCategoryID,1) where 
	waitingid=@waitingid
End





End

