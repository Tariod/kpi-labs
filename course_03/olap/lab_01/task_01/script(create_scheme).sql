-- Create the user 
create user TASK1
identified by "OLAP"
  default tablespace USERS
  temporary tablespace TEMP
  profile DEFAULT;
-- Grant/Revoke role privileges 
grant connect to TASK1;
grant resource to TASK1;
-- Grant/Revoke system privileges 
grant unlimited tablespace to TASK1;