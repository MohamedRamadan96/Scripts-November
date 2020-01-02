update invoice set[1stPayment]=0
update invoice set[1stPayment]=
(select  sum(PaymentAmount) from InvoiceRemitanceDetail
 where InvoiceRemitanceDetail.InvoiceNo=invoice.InvoiceID
 and InvoiceRemitanceDetail.PaymentDate=(select min(T1.PaymentDate) from InvoiceRemitanceDetail as T1 where T1.InvoiceNo=invoice.InvoiceID)
 group by InvoiceRemitanceDetail.PaymentDate)

 




update invoice set [1stPayReferrance] = null

update invoice set
[1stPayReferrance]=(select top 1 PaymentReference from InvoiceRemitanceDetail
 where InvoiceRemitanceDetail.InvoiceNo=invoice.InvoiceID
 and InvoiceRemitanceDetail.PaymentDate=(select min(T1.PaymentDate) from InvoiceRemitanceDetail as T1 where T1.InvoiceNo=invoice.InvoiceID)
 group by InvoiceRemitanceDetail.PaymentDate,PaymentReference)
-- having InvoiceRemitanceDetail.PaymentDate=min(InvoiceRemitanceDetail.PaymentDate))




update invoice set [2ndPayment] =0

update invoice set
[2ndPayment]=(select  sum(PaymentAmount) from InvoiceRemitanceDetail
 where InvoiceRemitanceDetail.InvoiceNo=invoice.InvoiceID and invoice.[1stPayReferrance]<>InvoiceRemitanceDetail.PaymentReference
  and InvoiceRemitanceDetail.PaymentDate=(select min(T1.PaymentDate) from InvoiceRemitanceDetail as T1 where
T1.InvoiceNo=invoice.InvoiceID and invoice.[1stPayReferrance]<>T1.PaymentReference)
 group by InvoiceRemitanceDetail.PaymentDate)
-- having InvoiceRemitanceDetail.PaymentDate=min(InvoiceRemitanceDetail.PaymentDate))



update invoice set [2ndPayReferrance] =null
update invoice set
[2ndPayReferrance]=(select PaymentReference from InvoiceRemitanceDetail
 where InvoiceRemitanceDetail.InvoiceNo=invoice.InvoiceID and invoice.[1stPayReferrance]<>InvoiceRemitanceDetail.PaymentReference
 and  InvoiceRemitanceDetail.PaymentDate=(select min(T1.PaymentDate) from InvoiceRemitanceDetail as T1 where
T1.InvoiceNo=invoice.InvoiceID and invoice.[1stPayReferrance]<>T1.PaymentReference)
 group by InvoiceRemitanceDetail.PaymentDate,PaymentReference)
-- having InvoiceRemitanceDetail.PaymentDate=min(InvoiceRemitanceDetail.PaymentDate))



update invoice set [3rdPayment]=0
update invoice set
[3rdPayment]=(select   sum(PaymentAmount) from InvoiceRemitanceDetail
 where InvoiceRemitanceDetail.InvoiceNo=invoice.InvoiceID and invoice.[1stPayReferrance]<>InvoiceRemitanceDetail.PaymentReference
  and invoice.[2ndPayReferrance]<>InvoiceRemitanceDetail.PaymentReference
 and InvoiceRemitanceDetail.PaymentDate=(select min(T1.PaymentDate) from InvoiceRemitanceDetail as T1 where
T1.InvoiceNo=invoice.InvoiceID and invoice.[1stPayReferrance]<>T1.PaymentReference and invoice.[2ndPayReferrance]<>T1.PaymentReference)

 group by InvoiceRemitanceDetail.PaymentDate)
-- having InvoiceRemitanceDetail.PaymentDate=min(InvoiceRemitanceDetail.PaymentDate))


update invoice set [3rdPayReferrance]=null
update invoice set
[3rdPayReferrance]=(select  PaymentReference from InvoiceRemitanceDetail
 where InvoiceRemitanceDetail.InvoiceNo=invoice.InvoiceID and invoice.[1stPayReferrance]<>InvoiceRemitanceDetail.PaymentReference
and invoice.[2ndPayReferrance]<>InvoiceRemitanceDetail.PaymentReference
 and InvoiceRemitanceDetail.PaymentDate=(select min(T1.PaymentDate) from InvoiceRemitanceDetail as T1 where
T1.InvoiceNo=invoice.InvoiceID and invoice.[1stPayReferrance]<>T1.PaymentReference and invoice.[2ndPayReferrance]<>T1.PaymentReference)
 group by InvoiceRemitanceDetail.PaymentDate,PaymentReference)
-- having InvoiceRemitanceDetail.PaymentDate=min(InvoiceRemitanceDetail.PaymentDate))





update invoice set [1stResubmission]=0
update invoice set
[1stResubmission]=(select  sum(Net) from EclaimInvoiceResubmission
 where EclaimInvoiceResubmission.EclaimInvoiceID=invoice.InvoiceID
  and  EclaimInvoiceResubmission.TransactionDate=(select min(T1.TransactionDate) from
  EclaimInvoiceResubmission as T1 where T1.EclaimInvoiceID=invoice.InvoiceID)
 group by EclaimInvoiceResubmission.TransactionDate)

-- having EclaimInvoiceResubmission.Start=min(EclaimInvoiceResubmission.Start))


update invoice set [1stResubmissionDate]=null
update invoice set
[1stResubmissionDate]=(select  EclaimInvoiceResubmission.TransactionDate from EclaimInvoiceResubmission
 where EclaimInvoiceResubmission.EclaimInvoiceID=invoice.InvoiceID
  and  EclaimInvoiceResubmission.TransactionDate=(select min(T1.TransactionDate) from
  EclaimInvoiceResubmission as T1 where T1.EclaimInvoiceID=invoice.InvoiceID)
 group by EclaimInvoiceResubmission.TransactionDate)





 update invoice set [2ndResubmission]=0
update invoice set
[2ndResubmission]=(select  sum(Net) from EclaimInvoiceResubmission
 where EclaimInvoiceResubmission.EclaimInvoiceID=invoice.InvoiceID
  and  EclaimInvoiceResubmission.TransactionDate=(select min(T1.TransactionDate) from
  EclaimInvoiceResubmission as T1 where T1.EclaimInvoiceID=invoice.InvoiceID)  and
   EclaimInvoiceResubmission.TransactionDate<>[1stResubmissionDate]
 group by EclaimInvoiceResubmission.TransactionDate)

-- having EclaimInvoiceResubmission.Start=min(EclaimInvoiceResubmission.Start))











update invoice set [1stRejection] =0
update invoice set [1stRejection]=CreditAmount-coalesce([1stPayment],0)where
invoice.[1stPayReferrance] is not null


update invoice set [2ndRejection]=0
update invoice set [2ndRejection]=coalesce([1stResubmission],0)-coalesce([2ndPayment],0)where
invoice.[2ndPayReferrance] is not null



update invoice set [1stDropResub]=0

update invoice set [1stDropResub]=coalesce(CreditAmount,0)-coalesce([1stPayment],0)where
invoice.[1stPayReferrance] is not null and
invoice.invoiceid not in(select EclaimInvoiceID from  EclaimInvoiceResubmission)



update invoice set  pendingAmount =0
update invoice set pendingAmount=CreditAmount
where PaymentReference is null