
SELECT   tabs.table_name, tabs.cluster_name, partitioned,
         iot_type, TEMPORARY, table_type, table_type_owner, tablespace_name,
         NESTED, last_analyzed, dropped,
         DECODE (   NVL (BUFFER_POOL, 'x')
                 || UPPER (partitioned)
                 || NVL (iot_type, 'x'),
                 'xNOx', 'YES',
                 'NO'
                ) is_external,
         num_rows
    FROM SYS.user_all_tables tabs
   WHERE 1 = 1 AND tabs.table_name ='MERCHANT'
ORDER BY table_name;

select * from sys.all_views where view_name like  '%PRI%'



-- Table column names
SELECT   cols.column_id, cols.column_name AS NAME, nullable,
         data_type AS TYPE,
         DECODE (data_type,
                 'CHAR', char_length,
                 'VARCHAR', char_length,
                 'VARCHAR2', char_length,
                 'NCHAR', char_length,
                 'NVARCHAR', char_length,
                 'NVARCHAR2', char_length,
                 NULL
                ) nchar_length,
         DECODE (data_type,
                 'NUMBER', data_precision + data_scale,
                 data_length
                ) LENGTH,
         data_precision PRECISION, data_scale scale, data_length dlength,
         data_default, ' ' comments, data_type_mod, cols.char_used,
         DECODE (cols.density, NULL, 'No', 'Yes') histogram
    FROM SYS.user_tab_columns cols
   WHERE 1 = 1 AND cols.table_name = 'UNPAID_SHOP_25M_CORR_MAR09'
ORDER BY column_id


-- Table Information

SELECT created, last_ddl_time, object_id, status, TIMESTAMP
  FROM SYS.user_objects
 WHERE object_name = 'CARD_MERCHANT' AND object_type = 'TABLE'

SELECT   cols.column_id, cols.column_name AS NAME, nullable,
         data_type AS TYPE,
         DECODE (data_type,
                 'CHAR', char_length,
                 'VARCHAR', char_length,
                 'VARCHAR2', char_length,
                 'NCHAR', char_length,
                 'NVARCHAR', char_length,
                 'NVARCHAR2', char_length,
                 NULL
                ) nchar_length,
         DECODE (data_type,
                 'NUMBER', data_precision + data_scale,
                 data_length
                ) LENGTH,
         data_precision PRECISION, data_scale scale, data_length dlength,
         data_default, ' ' comments, data_type_mod, cols.char_used,
         DECODE (cols.density, NULL, 'No', 'Yes') histogram
    FROM SYS.user_tab_columns cols
   WHERE 1 = 1 AND cols.table_name = 'UNPAID_CASH_25M_CORR_MAR09'
ORDER BY column_id

----------------------------------
Timestamp: 12:46:44.647

SELECT   a1.constraint_name, c1.column_name, c1.POSITION
    FROM SYS.user_cons_columns c1, SYS.user_constraints a1
   WHERE a1.table_name = c1.table_name
     AND a1.constraint_name = c1.constraint_name
     AND a1.constraint_type = 'P'
     AND a1.table_name = 'ACCOUNTS_LINK'
ORDER BY 3
----------------------------------
Timestamp: 12:46:45.413
SELECT created, last_ddl_time, object_id, status, TIMESTAMP
  FROM SYS.user_objects
 WHERE object_name = 'UNPAID_CASH_25M_CORR_MAR09' AND object_type = 'TABLE'
 
--indexs 
 SELECT   owner, index_name, uniqueness, status, index_type, TEMPORARY,
         partitioned, LOGGING, DEGREE, funcidx_status, join_index
    FROM SYS.dba_indexes
   WHERE table_owner = 'POWERCARD' AND table_name = 'UNPAID_CASH_25M_CORR_MAR09'
ORDER BY index_name

-- constraints
SELECT   constraint_name, constraint_type, r_constraint_name,
         INITCAP (status) status, INITCAP (delete_rule) delete_rule,
         r_constraint_name, r_owner, search_condition,
         INITCAP (DEFERRABLE) DEFERRABLE, INITCAP (DEFERRED) DEFERRED,
         INITCAP (validated) validated, INITCAP (bad) bad, INITCAP (RELY)
                                                                         RELY
    FROM SYS.user_constraints
   WHERE table_name = 'UNPAID_CASH_25M_CORR_MAR09'
ORDER BY 1

-- Trigers
\SELECT t.trigger_name, t.trigger_type, t.triggering_event, t.when_clause,
       t.status enabled, o.status, t.owner, o.object_id
  FROM SYS.dba_objects o, SYS.dba_triggers t
 WHERE t.table_owner = 'POWERCARD'
   AND o.object_type = 'TRIGGER'
   AND o.object_name = t.trigger_name
   AND t.table_name = 'UNPAID_CASH_25M_CORR_MAR09'
   AND o.owner = t.owner
   
   
   -- Grants
SELECT   PRIVILEGE, grantee, grantable, grantor, column_name
FROM SYS.dba_col_privs
WHERE table_name = 'UNPAID_CASH_25M_CORR_MAR09' AND owner = 'POWERCARD'
ORDER BY grantee

-- synonyms

Timestamp: 12:49:20.184
SELECT owner, synonym_name
  FROM dba_synonyms
 WHERE table_owner = 'POWERCARD' AND table_name = 'UNPAID_CASH_25M_CORR_MAR09'
 
-- Partition
SELECT   column_name, column_position
    FROM SYS.user_part_key_columns
   WHERE NAME = 'UNPAID_CASH_25M_CORR_MAR09'
ORDER BY NAME, column_position

-- Sub partitiom
SELECT   column_name, column_position
    FROM SYS.user_subpart_key_columns
   WHERE NAME = 'UNPAID_CASH_25M_CORR_MAR09'
ORDER BY NAME, column_position

-- State and size
SELECT *
  FROM SYS.user_tables
 WHERE table_name = 'UNPAID_CASH_25M_CORR_MAR09'
 
 
 
 --refrential
 SELECT   c1.owner, c1.constraint_name, c1.table_name, c1.r_owner,
         c1.r_constraint_name, c2.table_name r_table_name, c1.delete_rule,
         c1.status, c1.DEFERRABLE, c1.DEFERRED, c1.validated,
         c2.constraint_type r_constraint_type
    FROM SYS.dba_constraints c1, SYS.dba_constraints c2
   WHERE c1.constraint_type = 'R'
     AND c2.constraint_type IN ('P', 'U')
     AND c1.owner = 'POWERCARD'
     AND c1.table_name = 'UNPAID_CASH_25M_CORR_MAR09'
     AND c1.r_owner = c2.owner
     AND c1.r_constraint_name = c2.constraint_name
ORDER BY 1, 3


-- used ny
SELECT     TO_CHAR (object_id) object_id,
           TO_CHAR (referenced_object_id) referenced_object_id,
           TO_CHAR (LEVEL) "LEVEL"
      FROM public_dependency
CONNECT BY PRIOR object_id = referenced_object_id
START WITH referenced_object_id =
              (SELECT object_id
                 FROM SYS.dba_objects
                WHERE owner = 'POWERCARD'
                  AND object_name = 'UNPAID_CASH_25M_CORR_MAR09'
                  AND object_type = 'TABLE')
