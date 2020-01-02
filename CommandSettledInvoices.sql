
select waitingpatient.PatientID as FileNo , WaitingPatient.WaitingID as VisitNo , Invoice.InvoiceID as InvoiceNo , 
patients.Name  as PatientName , doctors.Name as DoctorName ,  Users.username as SettleInvoice , LastUser.UserName as LastEditInvoice

from INVOICE inner join Patients on Invoice.PatientID = Patients.PatientID 
		     inner join Doctors on Invoice.DoctorID = doctors.DoctorID 
			 inner join WaitingPatient on Invoice.VisitID = WaitingPatient.WaitingID 
			 inner join InvoiceHistory on (Invoice.InvoiceID = InvoiceHistory.InvoiceID and InvoiceHistory.action='Inserted')
			 inner join Users on InvoiceHistory.UpdatedBy = Users.UserID
			 inner join users As LastUser on  Invoice.UpdatedBy = LastUser.UserID
			 
			 

where 
    INVOICE.invoicedate between {?StDate} and {?EndDate}
   and doctors.BranchID={?BranchID}
 
