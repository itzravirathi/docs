set echo off
set feedback off
set linesize 512

prompt
prompt All AQ Tables in Database
prompt

SELECT *
	FROM DBA_QUEUE_TABLES
	ORDER BY OWNER, QUEUE_TABLE;
	
prompt
prompt All Advanced Queues in Database
prompt

SELECT OWNER, QUEUE_TABLE, NAME, QID, QUEUE_TYPE, MAX_RETRIES, RETRY_DELAY, ENQUEUE_ENABLED, DEQUEUE_ENABLED, RETENTION, USER_COMMENT
	FROM DBA_QUEUES
	ORDER BY OWNER, QUEUE_TABLE, NAME;