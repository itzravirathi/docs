set echo off
set feedback off
set linesize 512

prompt
prompt Rollback Segment Activity in Database
prompt

SELECT	 A.NAME, B.XACTS,
		 C.SID, C.SERIAL#,
		 C.USERNAME, D.SQL_TEXT
	FROM V$ROLLNAME A, V$ROLLSTAT B, V$SESSION C, V$SQLTEXT D, V$TRANSACTION E
   WHERE A.USN = B.USN
	 AND B.USN = E.XIDUSN
	 AND C.TADDR = E.ADDR
	 AND C.SQL_ADDRESS = D.ADDRESS
	 AND C.SQL_HASH_VALUE = D.HASH_VALUE
ORDER BY A.NAME, C.SID, D.PIECE;