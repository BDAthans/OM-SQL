-- SQL Profiler notes when gathering information to build RX Eyewear Order queries

SELECT rx_id as rxID, Frame_rx.patient_id, Frame_rx.LocationID, frame_rx.rx_order_cd, (patient.First_name +  ' ' + Patient.Last_name) as PatientName , Patient.day_phone as DayPhone, Promise_date as PromisedDate, tray_number as TrayNumber, vendor_name1 as LabName, code.description as LabStatus, Dispensed_by_date as FitDate, Ordered_by_date as OrderedDate, rcvd_by_date as ReceivedDate, dispensed_by,ordered_by,rcvd_by, notified_by_date,delivered_by_date, cancelled_by, cancelled_by_date 
FROM (frame_rx INNER JOIN patient ON Patient.Patient_no=frame_rx.patient_id) LEFT JOIN Vendor ON vendor.vendor_no=frame_rx.order_job_where LEFT JOIN Code ON code.code=frame_rx.rx_order_cd 

WHERE 1=1  AND Frame_rx.LocationID=2 AND Patient.active = 1  AND Ordered_by_date is not null  AND Rcvd_By_Date is null 

SELECT feeslip_no FROM patient_Open_Charges WHERE rx_id=37 AND Charge_type=0

SELECT feeslip_no FROM patient_Open_Charges WHERE rx_id=44 AND Charge_type=0

--NOTES:
--code.description as LabStatus
--Dispensed_by_date as FitDate
--Ordered_by_date as OrderedDate
--rcvd_by_date as ReceivedDate



-- After opening the RX Eyeweard order window in OM on patient ID 12:

SELECT Frame_RX.rx_id, Frame_RX.rx_entry_date, Frame_Lens_RX.Exam_Date, Frame_Lens_RX.Expiration_Date, Frame_RX.LocationID, Frame_RX.feeslip_no, Frame_RX.DeliveredOrderNumber, Frame_RX.Ordered_by, Frame_RX.Rcvd_By_Date, Frame_RX.rx_usage_cd, code.description, product.prd_desc,Product.prd_style_name, Frame_Lens_RX.UnderlyingCondition, Frame_Lens_Rx.Lens_Name 
FROM Frame_RX INNER JOIN Frame_Lens_RX ON Frame_RX.rx_id = Frame_Lens_RX.rx_id LEFT OUTER JOIN product ON Frame_Lens_RX.prd_no = product.prd_no LEFT OUTER JOIN Code ON Frame_RX.rx_usage_cd = code.code 
WHERE (Frame_RX.patient_id = 12) AND (Frame_Lens_RX.right_or_left_cd = 0) ORDER BY Frame_RX.rx_id DESC




After marking order as Received from Ordered in the Eyewear RX Window:

FROM patient_open_charges WHERE charge_type = 0 AND RX_ID = 25 -- RX_ID ties back to RXID in dbo.frame_rx
DELETE FROM frame_lens_RX_addon WHERE rx_id=25 -- line correlating to RX_ID was removed from frame_lens_RX_addon after marking order received
DELETE FROM patient_open_charges WHERE rx_id=25 AND charge_type = 0 AND feeslip_no = 0 --patient_open_charges table removed line correlating to RX_ID after marking received
UPDATE Frame_RX Set CreateOpenCharges=1 Where rx_id=25
UPDATE Cpr_Examination SET exam_posted = 1 WHERE Patient_no = 12AND exam_sequence = 0 AND Exam_date <= '02/01/2013'


SELECT rx_id, patient_id, CreateOpenCharges
WHERE rx_id=25


-- CreateOpenCharges is not the flag for an order be in ordered status.
