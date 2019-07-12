-- SELECT Query to show RX Eyewear Orders that are in ordered status that are older than specified date

DECLARE @removeBeforeThisDate nvarchar(1000) 
SET @removeBeforeThisDate = '2018-12-31 00:00:00:000';

SELECT rx_id, patient_id, promise_date, (patient.First_name +  ' ' + Patient.Last_name) as PatientName, 
code.description as LabStatus, Rcvd_By_Date, Rcvd_By, Notified_By_Date, Notified_By, Delivered_By_Date, Delivered_By
FROM (frame_rx INNER JOIN patient ON Patient.Patient_no=frame_rx.patient_id) LEFT JOIN Vendor ON vendor.vendor_no=frame_rx.order_job_where LEFT JOIN Code ON code.code=frame_rx.rx_order_cd
WHERE promise_Date < @removeBeforeThisDate
AND patient.active=1
AND Ordered_By_Date IS NOT NULL
AND Rcvd_By_Date is NULL

