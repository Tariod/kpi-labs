-- Create the user
ALTER USER TASK1
	WITH PASSWORD 'OLAP';
-- create user TASK1
-- identified by "OLAP"
--   default tablespace USERS
--   temporary tablespace TEMP
--   profile DEFAULT;

-- Grant/Revoke role privileges
GRANT CONNECT ON DATABASE SALE TO TASK1;
GRANT ALL PRIVILEGES ON DATABASE SALE TO TASK1;
-- grant resource to TASK1;

-- Grant/Revoke system privileges
-- grant unlimited tablespace to TASK1;
