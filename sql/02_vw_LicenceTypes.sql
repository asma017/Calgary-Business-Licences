/* ============================================================
   Calgary Business Licences – BI Portfolio Project
   02_vw_LicenceTypes.sql
   Splits the comma-separated LICENCETYPES column so each
   licence type gets its own row. Used in Power BI for the
   Licence Type slicer and the "Licences by Type" chart.

   Note: a business with 2 licence types appears twice in this
   view, so licence type totals add up to more than the number
   of businesses.
   ============================================================ */

USE CalgaryBusinessLicensesDB;
GO

CREATE VIEW dbo.vw_LicenceTypes AS
SELECT
    b.GETBUSID,
    b.TRADENAME,
    b.COMDISTNM      AS Community,
    TRIM(s.value)    AS LicenceType
FROM dbo.calgary_business_licenses_clean AS b
CROSS APPLY STRING_SPLIT(b.LICENCETYPES, ',') AS s;
GO
