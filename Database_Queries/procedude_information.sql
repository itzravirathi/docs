SELECT   o.*, NVL (d.debuginfo, 'F') debuginfo,
         NVL (p.AUTHID, 'CURRENT_USER') AUTHID
    FROM (SELECT object_name, DECODE (status, 'VALID', 'V', 'I') status,
                 last_ddl_time, object_id, created
            FROM SYS.user_objects
           WHERE 1 = 1 AND object_type = 'PROCEDURE' AND status = 'VALID') o,
         SYS.all_probe_objects d,
         (SELECT   object_name, AUTHID
              FROM SYS.user_procedures
             WHERE 1 = 1
          GROUP BY object_name, AUTHID) p
   WHERE p.object_name(+) = o.object_name
     AND o.object_id = d.object_id(+)
     AND d.owner(+) = 'POWERCARD'
     AND o.object_name = d.object_name(+)
     AND ((d.object_type IS NULL) OR (d.object_type = 'TABLE'))
     and o.object_name like '%BAL%'
ORDER BY 1

SELECT   o.*, NVL (d.debuginfo, 'F') debuginfo,
         NVL (p.AUTHID, 'CURRENT_USER') AUTHID
    FROM (SELECT object_name, DECODE (status, 'VALID', 'V', 'I') status,
                 last_ddl_time, object_id, created
            FROM SYS.user_objects
           WHERE 1 = 1
             AND object_type = 'PROCEDURE'
             AND status = 'VALID'
             AND object_name LIKE '%BAL%') o,
         SYS.all_probe_objects d,
         (SELECT   object_name, AUTHID
              FROM SYS.user_procedures
             WHERE 1 = 1
          GROUP BY object_name, AUTHID) p
   WHERE p.object_name(+) = o.object_name
     AND o.object_id = d.object_id(+)
     AND d.owner(+) = 'POWERCARD'
     AND o.object_name = d.object_name(+)
     AND ((d.object_type IS NULL) OR (d.object_type = 'PROCEDURE'))
ORDER BY 1



-- source

SELECT created, last_ddl_time, object_id, status, TIMESTAMP
  FROM SYS.user_objects
 WHERE object_name = 'BAL_FINANCE' AND object_type = 'PROCEDURE'
----------------------------------
Timestamp: 12:51:49.900
SELECT   text
    FROM SYS.user_source
   WHERE NAME = 'BAL_FINANCE' AND TYPE = 'PROCEDURE'
ORDER BY line

--- uses
SELECT a.object_type, a.object_name, b.owner, b.object_type, b.object_name,
       b.object_id, b.status
  FROM SYS.dba_objects a,
       SYS.dba_objects b,
       (SELECT     object_id, referenced_object_id
              FROM public_dependency
        START WITH object_id =
                      (SELECT object_id
                         FROM SYS.dba_objects
                        WHERE owner = 'POWERCARD'
                          AND object_name = 'BAL_FINANCE'
                          AND object_type = 'PROCEDURE')
        CONNECT BY PRIOR referenced_object_id = object_id) c
 WHERE a.object_id = c.object_id
   AND b.object_id = c.referenced_object_id
   AND a.owner NOT IN ('SYS', 'SYSTEM')
   AND b.owner NOT IN ('SYS', 'SYSTEM')
   AND a.object_name <> 'DUAL'
   AND b.object_name <> 'DUAL'

-- used by 

SELECT     TO_CHAR (object_id) object_id,
           TO_CHAR (referenced_object_id) referenced_object_id,
           TO_CHAR (LEVEL) "LEVEL"
      FROM public_dependency
CONNECT BY PRIOR object_id = referenced_object_id
START WITH referenced_object_id =
              (SELECT object_id
                 FROM SYS.dba_objects
                WHERE owner = 'POWERCARD'
                  AND object_name = 'BAL_FINANCE'
                  AND object_type = 'PROCEDURE')
                  
-- grants

SELECT   PRIVILEGE, grantee, grantable, grantor
    FROM SYS.dba_tab_privs
   WHERE table_name = 'BAL_FINANCE' AND owner = 'POWERCARD'
ORDER BY grantee

