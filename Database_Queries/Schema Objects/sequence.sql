set echo off
set feedback off
set linesize 512

prompt
prompt All Sequences in Database
prompt

break on SEQUENCE_OWNER skip 1

SELECT	 SEQUENCE_OWNER, SEQUENCE_NAME, MIN_VALUE, MAX_VALUE, INCREMENT_BY,
		 DECODE (CYCLE_FLAG, 'Y', 'YES', 'N', 'NO') CYCLE_FLAG,
		 DECODE (ORDER_FLAG, 'Y', 'YES', 'N', 'NO') ORDER_FLAG, CACHE_SIZE,
		 LAST_NUMBER
	FROM DBA_SEQUENCES
	WHERE SEQUENCE_OWNER NOT IN ('SYS','SYSTEM','OUTLN','DBSNMP')
ORDER BY 1, 2;