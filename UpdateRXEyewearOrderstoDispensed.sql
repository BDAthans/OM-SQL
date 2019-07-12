-- UPDATE query to update RX Eyewear Orders that are older than a specific date to be received, notified and dispensed (delivered).

DECLARE @providerID int;
SET @providerID = 1;

DECLARE @removeBeforeThisDate nvarchar(1000) 
SET @removeBeforeThisDate = '2018-12-31 00:00:00:000';


Update frame_RX
SET Rcvd_By_Date='2019-07-11 00:00:00:000', Rcvd_By=@providerID, 
Notified_By_Date='2019-07-11 00:00:00:000', Notified_By=@providerID,
Delivered_By_Date='2019-07-11 00:00:00:000', Delivered_By=@providerID
FROM dbo.Frame_RX
JOIN dbo.patient
ON patient.patient_no=frame_RX.patient_id
WHERE promise_Date < @removeBeforeThisDate
AND patient.active=1
AND Ordered_By_Date IS NOT NULL
AND Rcvd_By_Date is NULL


-- FROM (frame_rx INNER JOIN patient ON Patient.Patient_no=frame_rx.patient_id) LEFT JOIN Vendor ON vendor.vendor_no=frame_rx.order_job_where LEFT JOIN Code ON code.code=frame_rx.rx_order_cd