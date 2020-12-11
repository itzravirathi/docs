set echo off
set feedback off
set linesize 512

prompt
prompt All Granted Roles in Database
prompt

break on GRANTED_ROLE skip 1

SELECT GRANTED_ROLE, GRANTEE, ADMIN_OPTION, DEFAULT_ROLE
	FROM DBA_ROLE_PRIVS
	WHERE GRANTEE IN (SELECT USERNAME FROM SYS.DBA_USERS)
	ORDER BY GRANTED_ROLE, ADMIN_OPTION;