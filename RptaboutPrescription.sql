select waitingpatient.PatientId ,  waitingpatient.WaitingID ,  waitingpatient.Patient , 
 Doctors.name as DoctorName ,  waitingpatient.ArrDate as [Visit Date], patients.mobile  
 , 
    substring(
        (
            Select ',' + PatientDrugs.PackageName + ','   AS [text()]
            From dbo.PatientDrugs 
           
            Where PatientDrugs.WaitingID = WaitingPatient.WaitingID 
            For XML PATH ('')
        ), 2, 1000) [Prescription]

from WaitingPatient inner join patients 

on WaitingPatient.PatientID = Patients.PatientID inner join
Doctors on Doctors.DoctorID=WaitingPatient.DoctorID
where ArrDate between '11-18-2019' and '11-19-2019' 

