-- Query the SYSTABLES table by the schema name to display 
-- the five tables that belong to the sample HR database.

SELECT * FROM SYSIBM. SYSTABLES WHERE CREATOR = 'DTY43273';


-- Try directly deleting the row corresponding to the EMPLOYEES table 
-- from the SYSIBM.SYSTABLES system table.

DELETE FROM SYSIBM. SYSTABLES WHERE NAME='EMPLOYEES';

-- Drop the EMPLOYEES table from the database.

DROP TABLE EMPLOYEES;

-- Once again, query the SYSTABLES table by schema name to confirm that 
-- the EMPLOYEES table was successfully dropped from the database.

SELECT * FROM SYSIBM. SYSTABLES WHERE CREATOR = 'DTY43273';