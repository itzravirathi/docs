SELECT LOK.ORACLE_USERNAME,LOK.os_user_name,OBJ.object_name,OBJ.object_type,session_id,sess.sid,sess.serial#
FROM sys.v_$locked_object LOK, SYS.ALL_OBJECTS OBJ,v$session sess
WHERE sess.sid=lok.session_id 
and LOK.object_id = OBJ.object_id
and OBJ.OBJECT_TYPE='TABLE';


--alter session set nls_numeric_characters ='.,';


select ('alter system kill session'''||sess.sid||','||sess.serial#||''';') 
FROM sys.v_$locked_object LOK, SYS.ALL_OBJECTS OBJ,v$session sess
WHERE LOK.object_id = OBJ.object_id
and sess.sid=lok.session_id


alter system kill session'1074,1124';

