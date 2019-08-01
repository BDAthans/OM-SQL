-- UPDATE query to update RX Eyewear Orders that are older than a specific date to be received, notified and dispensed (delivered).

DECLARE @providerID int;
DECLARE @removeBeforeThisDate nvarchar(1000);
DECLARE @newOrderDate nvarchar(1000);
SET @providerID = 1;
SET @removeBeforeThisDate = '2018-12-31 00:00:00:000';
SET @newOrderDate = '2019-07-11 00:00:00:000';


Update frame_RX
SET Rcvd_By_Date=@newOrderDate, Rcvd_By=@providerID, 
Notified_By_Date=@newOrderDate, Notified_By=@providerID,
Delivered_By_Date=@newOrderDate, Delivered_By=@providerID
FROM dbo.Frame_RX
JOIN dbo.patient
ON patient.patient_no=frame_RX.patient_id
WHERE promise_Date < @removeBeforeThisDate
AND patient.active=1
AND Ordered_By_Date IS NOT NULL
AND Rcvd_By_Date is NULL
