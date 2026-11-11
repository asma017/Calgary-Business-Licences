/* ============================================================
   Calgary Business Licences – BI Portfolio Project
   03_vw_CommunitySummary.sql
   One row per community with the total number of businesses
   and the number of food service businesses.
   ============================================================ */

USE CalgaryBusinessLicensesDB;
GO

CREATE VIEW dbo.vw_CommunitySummary AS
SELECT
    COMDISTNM AS Community,
    COUNT(*)  AS TotalBusinesses,
    SUM(CASE WHEN LICENCETYPES LIKE '%FOOD SERVICE%' THEN 1 ELSE 0 END) AS FoodBusinesses
FROM dbo.calgary_business_licenses_clean
WHERE COMDISTNM IS NOT NULL
GROUP BY COMDISTNM;
GO
