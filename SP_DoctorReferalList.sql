USE [ClinicPro]
GO
/****** Object:  StoredProcedure [dbo].[SPR_DoctorReferalList]    Script Date: 11/24/2019 9:40:51 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[SPR_DoctorReferalList]
	@StDate datetime,
	@EndDate datetime,
	@DoctorID  nvarchar,
	@BranchID   int


AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

SELECT     dbo.Clinics.Clinic AS TransferFromClinic, dbo.Doctors.Name AS TransferFromDoctor, dbo.WaitingPatient.ArrDate AS TransferDate, Clinics_1.Clinic AS TransferToClinic, 
                      Doctors_1.Name AS TransferToDoctor, dbo.Patients.PatientID AS FileNo, dbo.Patients.Name AS Patient
FROM         dbo.Clinics AS Clinics_1 INNER JOIN
                      dbo.Doctors AS Doctors_1 ON Clinics_1.CinicID = Doctors_1.ClinicID INNER JOIN
                      dbo.Doctors INNER JOIN
                      dbo.WaitingPatient ON dbo.Doctors.DoctorID = dbo.WaitingPatient.DoctorID INNER JOIN
                      dbo.DoctorReferral ON dbo.DoctorReferral.VisitID = dbo.WaitingPatient.WaitingID INNER JOIN
                      dbo.Clinics ON dbo.Clinics.CinicID = dbo.Doctors.ClinicID ON Doctors_1.DoctorID = dbo.DoctorReferral.DoctorID INNER JOIN
                      dbo.Patients ON dbo.WaitingPatient.PatientID = dbo.Patients.PatientID
WHERE  dbo.WaitingPatient.ArrDate between @StDate and @EndDate
AND (WaitingPatient.DoctorID =@DoctorID or @DoctorID =0)
and dbo.Doctors.BranchID=@BranchID

union all
SELECT     dbo.Clinics.Clinic AS TransferFromClinic, dbo.Doctors.Name AS TransferFromDoctor, dbo.WaitingPatient.ArrDate AS TransferDate, ' ' AS TransferToClinic, 
                      DoctorReferral.ReferredTo, dbo.Patients.PatientID AS FileNo, dbo.Patients.Name AS Patient
FROM       
                      dbo.WaitingPatient INNER JOIN
                      dbo.DoctorReferral ON dbo.DoctorReferral.VisitID = dbo.WaitingPatient.WaitingID INNER JOIN
                      dbo.Patients ON dbo.WaitingPatient.PatientID = dbo.Patients.PatientID
                  INNER JOIN
                      dbo.Doctors ON dbo.Doctors.DoctorID = WaitingPatient.DoctorID
INNER JOIN
                      dbo.Clinics ON dbo.Clinics.CinicID = dbo.Doctors.ClinicID 
WHERE  dbo.WaitingPatient.ArrDate between @StDate and @EndDate
AND (WaitingPatient.DoctorID =@DoctorID or @DoctorID =0)
and dbo.Doctors.BranchID=@BranchID

End
