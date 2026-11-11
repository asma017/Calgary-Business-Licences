/* ============================================================
   Calgary Business Licences – BI Portfolio Project
   04_analysis_queries.sql
   Analysis queries that answer the project's business
   questions and check the numbers shown in Power BI.
   ============================================================ */

USE CalgaryBusinessLicensesDB;
GO

-- 1. Total licences, active licences and active %
--    Active = status is "Licensed" or "Renewal Licensed" (same as the Power BI measure)
SELECT
    COUNT(*) AS TotalLicences,
    SUM(CASE WHEN JOBSTATUSDESC IN ('Licensed', 'Renewal Licensed') THEN 1 ELSE 0 END) AS ActiveLicences,
    CAST(SUM(CASE WHEN JOBSTATUSDESC IN ('Licensed', 'Renewal Licensed') THEN 1 ELSE 0 END) * 100.0
         / COUNT(*) AS DECIMAL(5,1)) AS ActivePct
FROM dbo.calgary_business_licenses_clean;

-- 2. Top 10 communities by number of licences
SELECT TOP 10
    COMDISTNM AS Community,
    COUNT(*)  AS TotalLicences
FROM dbo.calgary_business_licenses_clean
WHERE COMDISTNM IS NOT NULL
GROUP BY COMDISTNM
ORDER BY TotalLicences DESC;

-- 3. Licences by status
SELECT
    JOBSTATUSDESC AS Status,
    COUNT(*)      AS TotalLicences
FROM dbo.calgary_business_licenses_clean
GROUP BY JOBSTATUSDESC
ORDER BY TotalLicences DESC;

-- 4. Top 10 communities by food business share
--    (only communities with 50+ businesses, so tiny ones don't distort the ranking)
--    100.0 forces decimal division instead of integer division
SELECT TOP 10
    Community,
    TotalBusinesses,
    FoodBusinesses,
    CAST(FoodBusinesses * 100.0 / TotalBusinesses AS DECIMAL(5,1)) AS FoodSharePct
FROM dbo.vw_CommunitySummary
WHERE TotalBusinesses >= 50
ORDER BY FoodSharePct DESC;

-- 5. Top 10 licence types
SELECT TOP 10
    LicenceType,
    COUNT(*) AS TotalLicences
FROM dbo.vw_LicenceTypes
GROUP BY LicenceType
ORDER BY TotalLicences DESC;

-- 6. Licences by year first issued
SELECT
    YEAR(FIRST_ISS_DT) AS YearFirstIssued,
    COUNT(*)           AS TotalLicences
FROM dbo.calgary_business_licenses_clean
WHERE FIRST_ISS_DT IS NOT NULL
GROUP BY YEAR(FIRST_ISS_DT)
ORDER BY YearFirstIssued;

-- 7. Licences expiring in the next 90 days
SELECT COUNT(*) AS ExpiringNext90Days
FROM dbo.calgary_business_licenses_clean
WHERE EXP_DT BETWEEN CAST(GETDATE() AS DATE)
                 AND DATEADD(DAY, 90, CAST(GETDATE() AS DATE));

-- 8. Upcoming expiries by month (next 12 months)
SELECT
    FORMAT(EXP_DT, 'yyyy-MM') AS ExpiryMonth,
    COUNT(*)                  AS LicencesExpiring
FROM dbo.calgary_business_licenses_clean
WHERE EXP_DT >= CAST(GETDATE() AS DATE)
  AND EXP_DT <  DATEADD(MONTH, 12, CAST(GETDATE() AS DATE))
GROUP BY FORMAT(EXP_DT, 'yyyy-MM')
ORDER BY ExpiryMonth;
