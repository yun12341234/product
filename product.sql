SELECT 
    A.JobDate, A.JobNo, A.JobType, A.AwbBlNo as BookingNo, 
    A.CustomerCode, A.CustomerName, A.ContainerNo,
    A.ContainerType1, A.NoOfContainer1, A.NoOfContainer2,
    a.NoOfContainer3, a.NoOfContainer4, 
    A.DriverCode, A.DriverName, D.itemcode, D.Description, D.Qty as SalesQty, D.UnitRate As SalesUnitRate,
    D.UomCode AS UomCode, D.VatCode, D.CurrCode, D.CurrRate, D.Amt, D.OriginalSalesAmt,
    D.SalesApproveFlag, D.CostQty, D.CostUnitRate, D.CostPpCcFlag,
    D.VendorName, D.CostVatCode, D.CostCurrCode, D.CostCurrRate,
    D.CostAmt, D.CommissionCode, D.OriginalCostAmt, D.CostApproveFlag, I.InvoiceNo
FROM 
    dbo.Jmjm1 AS A
RIGHT JOIN (
    SELECT DISTINCT JobNo, itemcode, Description, Qty, UnitRate, UomCode, VatCode, 
                    CurrCode, CurrRate, Amt, OriginalSalesAmt, SalesApproveFlag,
                    CostQty, CostUnitRate, CostPpCcFlag, VendorName, CostVatCode,
                    CostCurrCode, CostCurrRate, CostAmt, CommissionCode, OriginalCostAmt,
                    CostApproveFlag
    FROM dbo.jmjm2
) AS D ON A.jobno = D.JobNo
Right JOIN (
    SELECT JobNo, InvoiceNo
    FROM dbo.plvi1
    GROUP BY JobNo , InvoiceNo
) AS I ON A.jobno = I.JobNo
WHERE 
    A.JobDate >= '2023-01-01' 
ORDER BY A.JobDate, A.jobno;


-- 
SELECT
    COUNT(CASE WHEN CostApproveFlag IS NULL THEN 1 END) AS CostUnapproved,
    COUNT(CASE WHEN CostApproveFlag IS NOT NULL THEN 1 END) AS Costapproved ,
	COUNT(CASE WHEN SalesApproveFlag IS NULL THEN 1 END) As SalesUnApproved,
	COUNT(CASE WHEN SalesApproveFlag IS NOT NULL THEN 1 END) AS Salesapproved
FROM 
    dbo.jmjm2 AS A







