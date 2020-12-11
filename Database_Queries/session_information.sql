SELECT   s.module ,s.SID, s.serial#,s.status, s.server,
         s.schema#, s.schemaname, s.osuser, s.process, s.machine, s.terminal,
         UPPER (s.program) program, ROUND (BITAND (s.ownerid, 65535)) parent_session_sid,
             ROUND (BITAND (s.ownerid, 16711680) / 65536) parent_session_instid,
         s.saddr,  s.audsid, s.paddr, s.user#, s.username,
         s.command, s.ownerid, s.taddr, s.lockwait,  s.TYPE, s.sql_address, s.sql_hash_value,
         s.sql_id, s.sql_child_number, s.prev_sql_addr, s.prev_hash_value,
         s.prev_sql_id, s.prev_child_number, s.plsql_entry_object_id,
         s.plsql_entry_subprogram_id, s.plsql_object_id,
         s.plsql_subprogram_id,  s.module_hash, s.action,
         s.action_hash, s.client_info, s.fixed_table_sequence,
         s.row_wait_obj#, s.row_wait_file#, s.row_wait_block#,
         s.row_wait_row#, s.logon_time, s.last_call_et, s.pdml_enabled,
         s.failover_type, s.failover_method, s.failed_over,
         s.resource_consumer_group, s.pdml_status, s.pddl_status, s.pq_status,
         s.current_queue_duration, s.client_identifier,
         s.blocking_session_status, s.blocking_instance, s.blocking_session,
         s.seq#, s.event#, s.event, s.p1text, s.p1, s.p1raw, s.p2text, s.p2,
         s.p2raw, s.p3text, s.p3, s.p3raw, s.wait_class_id, s.wait_class#,
         s.wait_class, s.wait_time, s.seconds_in_wait, s.state,
         s.service_name, s.sql_trace, s.sql_trace_waits, s.sql_trace_binds
    FROM  SYS.V_$SESSION s
   WHERE (    (s.username IS NOT NULL)
          AND (NVL (s.osuser, 'x') <> 'SYSTEM')
          AND (s.TYPE <> 'BACKGROUND')
         )
        --  and username ='STAGING_PR'
             and status = 'ACTIVE'
         -- and s.machine ='CPUNUN0101'
ORDER BY "OSUSER", ownerid;


SELECT s.sid, s.serial#, s.username, s.osuser, p.spid, s.machine, p.terminal, s.program
FROM v$session s, v$process p
WHERE s.paddr = p.addr;


SELECT s.sid,
       s.serial#,
       p.spid,
       s.username,
       s.program
FROM   v$session s
       JOIN v$process p ON p.addr = s.paddr 
WHERE  p.spid in( 21221,21223);

SELECT s.sid,
       s.serial#,
       p.spid,
       s.username,
       s.program
FROM   v$session s
       JOIN v$process p ON p.addr = s.paddr 
WHERE  s.sid in(945);


-- Time Estimation
select  sid, rpad(lpad('-',ceil( decode (totalwork,0, 0,round (100 * sofar / totalwork, 2)) /5),'*'),19,'-') progress, 
       DECODE (totalwork,0, 0,ROUND (100 * sofar / totalwork, 2)) "Percent",
         MESSAGE "Message", start_time, elapsed_seconds, time_remaining
    FROM v$session_longops
WHERE  
1=1 
-- and  (SID = 915 AND serial# = 25813) OR (SID = 903 AND serial# = 37068)
and SID = 857
-- and (SID,serial#) in (select 888,15433 from dual)
order by sid ,time_remaining desc;

-- Session current statement
SELECT   sql_text   FROM SYS.v_$sqltext_with_newlines
   WHERE address = (SELECT DECODE (RAWTOHEX (sql_address),
                            '00', prev_sql_addr,
                            sql_address)
               from sys.v_$session where -- username = 'STAGING_PR' AND 
               SID = 828 )
ORDER BY piece;


-- session Disconnect

ALTER SYSTEM DISCONNECT SESSION '828,61622' IMMEDIATE -- (SID = 968 AND serial# = 48665)
;

-- Session Kill
ALTER SYSTEM KILL SESSION '828,61622' -- (SID = 968 AND serial# = 48665)
;


1046	1904
1073	9047


-- session lock
SELECT lk.SID, se.username, se.osuser, se.machine,
       DECODE (lk.TYPE,
               'TX', 'Transaction',
               'TM', 'DML',
               'UL', 'PL/SQL User Lock',
               lk.TYPE
              ) lock_type,
       DECODE (lk.lmode,
               0, 'None',
               1, 'Null',
               2, 'Row-S (SS)',
               3, 'Row-X (SX)',
               4, 'Share',
               5, 'S/Row-X (SSX)',
               6, 'Exclusive',
               TO_CHAR (lk.lmode)
              ) mode_held,
       DECODE (lk.request,
               0, 'None',
               1, 'Null',
               2, 'Row-S (SS)',
               3, 'Row-X (SX)',
               4, 'Share',
               5, 'S/Row-X (SSX)',
               6, 'Exclusive',
               TO_CHAR (lk.request)
              ) mode_requested,
       TO_CHAR (lk.id1) lock_id1, TO_CHAR (lk.id2) lock_id2, BLOCK,
       se.lockwait
  FROM v$lock lk, SYS.V_$SESSION se
 WHERE (lk.TYPE = 'TX') AND (lk.SID = se.SID) ;



SELECT lk.SID, se.username, se.osuser, se.machine,
       DECODE (lk.TYPE,
               'TX', 'Transaction',
               'TM', 'DML',
               'UL', 'PL/SQL User Lock',
               lk.TYPE
              ) lock_type,
       DECODE (lk.lmode,
               0, 'None',
               1, 'Null',
               2, 'Row-S (SS)',
               3, 'Row-X (SX)',
               4, 'Share',
               5, 'S/Row-X (SSX)',
               6, 'Exclusive',
               TO_CHAR (lk.lmode)
              ) mode_held,
       DECODE (lk.request,
               0, 'None',
               1, 'Null',
               2, 'Row-S (SS)',
               3, 'Row-X (SX)',
               4, 'Share',
               5, 'S/Row-X (SSX)',
               6, 'Exclusive',
               TO_CHAR (lk.request)
              ) mode_requested,
       TO_CHAR (lk.id1) lock_id1, TO_CHAR (lk.id2) lock_id2, ob.owner,
       ob.object_type, ob.object_name, lk.BLOCK, se.lockwait
  FROM v$lock lk, dba_objects ob, SYS.V_$SESSION se
 WHERE lk.TYPE IN ('TM', 'UL') AND lk.SID = se.SID AND lk.id1 = ob.object_id(+) 
 ;
 
 

SELECT lk.SID, se.username, se.osuser, se.machine,
       DECODE (lk.TYPE,
               'TX', 'Transaction',
               'TM', 'DML',
               'UL', 'PL/SQL User Lock',
               lk.TYPE
              ) lock_type,
       DECODE (lk.lmode,
               0, 'None',
               1, 'Null',
               2, 'Row-S (SS)',
               3, 'Row-X (SX)',
               4, 'Share',
               5, 'S/Row-X (SSX)',
               6, 'Exclusive',
               TO_CHAR (lk.lmode)
              ) mode_held,
       DECODE (lk.request,
               0, 'None',
               1, 'Null',
               2, 'Row-S (SS)',
               3, 'Row-X (SX)',
               4, 'Share',
               5, 'S/Row-X (SSX)',
               6, 'Exclusive',
               TO_CHAR (lk.request)
              ) mode_requested,
       TO_CHAR (lk.id1) lock_id1, TO_CHAR (lk.id2) lock_id2, BLOCK,
       se.lockwait
  FROM v$lock lk, v$session se
 WHERE (lk.TYPE = 'TX') AND (lk.SID = se.SID) AND (lk.SID = '894')
 
----------------------------------
Timestamp: 12:41:04.140
SELECT lk.SID, se.username, se.osuser, se.machine,
       DECODE (lk.TYPE,
               'TX', 'Transaction',
               'TM', 'DML',
               'UL', 'PL/SQL User Lock',
               lk.TYPE
              ) lock_type,
       DECODE (lk.lmode,
               0, 'None',
               1, 'Null',
               2, 'Row-S (SS)',
               3, 'Row-X (SX)',
               4, 'Share',
               5, 'S/Row-X (SSX)',
               6, 'Exclusive',
               TO_CHAR (lk.lmode)
              ) mode_held,
       DECODE (lk.request,
               0, 'None',
               1, 'Null',
               2, 'Row-S (SS)',
               3, 'Row-X (SX)',
               4, 'Share',
               5, 'S/Row-X (SSX)',
               6, 'Exclusive',
               TO_CHAR (lk.request)
              ) mode_requested,
       TO_CHAR (lk.id1) lock_id1, TO_CHAR (lk.id2) lock_id2, ob.owner,
       ob.object_type, ob.object_name, lk.BLOCK, se.lockwait
  FROM v$lock lk, dba_objects ob, v$session se
 WHERE lk.TYPE IN ('TM', 'UL')
   AND lk.SID = se.SID
   AND lk.id1 = ob.object_id(+)
   AND (lk.SID = '894')
   
   
-- Remaing time 
SELECT   SID,
         DECODE (totalwork,
                 0, 0,
                 ROUND (100 * sofar / totalwork, 2)
                ) "Percent",
         MESSAGE "Message", start_time, elapsed_seconds, time_remaining
    FROM v$session_longops
   WHERE (SID = 894 AND serial# = 33566)
ORDER BY SID
