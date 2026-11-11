/* ============================================================
   Calgary Business Licences – BI Portfolio Project
   01_create_table.sql
   Creates the table that holds the cleaned business licence
   data (exported from Excel Power Query).
   Source: City of Calgary Open Data – Business Licences
   ============================================================ */

USE CalgaryBusinessLicensesDB;
GO

-- Note: no primary key on GETBUSID.
-- 12 business IDs appear twice because they are valid
-- "Move in Progress" pairs (old and new address), not duplicates.
CREATE TABLE dbo.calgary_business_licenses_clean (
    GETBUSID        INT            NULL,  -- Business ID
    TRADENAME       NVARCHAR(200)  NULL,  -- Business trade name
    ADDRESS         NVARCHAR(50)   NULL,
    COMDISTCD       NVARCHAR(50)   NULL,  -- Community code
    COMDISTNM       NVARCHAR(50)   NULL,  -- Community name
    LICENCETYPES    VARCHAR(MAX)   NULL,  -- One or more licence types, comma-separated
    FIRST_ISS_DT    DATE           NULL,  -- Date licence was first issued
    EXP_DT          DATE           NULL,  -- Licence expiry date
    JOBSTATUSDESC   NVARCHAR(50)   NULL,  -- Licence status (e.g. Renewal Licensed)
    POINT           NVARCHAR(50)   NULL,  -- Original location text
    GLOBALID        NVARCHAR(50)   NULL,
    Longitude       FLOAT          NULL,  -- Split from POINT in Power Query
    Latitude        FLOAT          NULL   -- Split from POINT in Power Query
);
GO
