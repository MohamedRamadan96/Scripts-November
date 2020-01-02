

update WaitingPatient   set CategoryID=coalesce(patients.InsuranceCompany,1)  
from WaitingPatient inner join patients on  patients.patientid=WaitingPatient.patientid
where WaitingPatient.categoryid is null
