

SELECT owner,
       DECODE (object_type, 'MATERIALIZED VIEW', 'SNAPSHOT', object_type),
       ' ' result_type, object_name
  FROM dba_objects
 WHERE (UPPER (object_name) LIKE '%%UNPAID%') AND (owner IN ('POWERCARD'))
UNION ALL
SELECT log_owner, 'SNAPSHOT LOG', ' ' result_type, MASTER
  FROM dba_snapshot_logs
 WHERE (UPPER (MASTER) LIKE '%%UNPAID%') AND (log_owner IN ('POWERCARD'))
UNION ALL
SELECT owner, 'CONSTRAINT' object_type, ' ' result_type,
       constraint_name object_name
  FROM dba_constraints
 WHERE (UPPER (constraint_name) LIKE '%%UNPAID%') AND (owner IN ('POWERCARD'))
UNION ALL
SELECT allo.owner,
       DECODE (allo.object_type,
               'VIEW', 'VIEW COLUMN',
               'TABLE', 'TABLE COLUMN',
               'MATERIALIZED VIEW', 'SNAPSHOT COLUMN',
               'CLUSTER', 'CLUSTER COLUMN',
               'UNDEFINED', 'UNDEFINED COLUMN',
               ' '
              ) object_type,
       atc.table_name result_type, atc.column_name object_name
  FROM dba_tab_columns atc, dba_objects allo
 WHERE (UPPER (atc.column_name) LIKE '%%UNPAID%')
   AND (atc.owner IN ('POWERCARD'))
   AND (allo.object_name = atc.table_name)
   AND (allo.owner = atc.owner)
   AND (allo.object_type IN
               ('TABLE', 'VIEW', 'CLUSTER', 'MATERIALIZED VIEW', 'UNDEFINED')
       )
UNION ALL
SELECT trigger_owner owner, 'TRIGGER COLUMN' object_type,
       trigger_name result_type, column_name object_name
  FROM dba_trigger_cols, dba_objects allo
 WHERE (UPPER (column_name) LIKE '%%UNPAID%')
   AND (trigger_owner IN ('POWERCARD'))
   AND (allo.owner = trigger_owner)
   AND (allo.object_name = trigger_name)
   AND (allo.object_type = 'TRIGGER')
UNION ALL
SELECT aic.index_owner owner, 'INDEX COLUMN' object_type,
       aic.index_name result_type, aic.column_name object_name
  FROM dba_ind_columns aic, dba_indexes ai
 WHERE (UPPER (aic.column_name) LIKE '%%UNPAID%')
   AND (ai.owner = aic.index_owner)
   AND (ai.index_name = aic.index_name)
   AND (aic.index_owner IN ('POWERCARD'))
UNION ALL
SELECT owner, 'CONSTRAINT COLUMN' object_type, constraint_name result_type,
       column_name object_name
  FROM dba_cons_columns
 WHERE (UPPER (column_name) LIKE '%%UNPAID%') AND (owner IN ('POWERCARD'))
UNION ALL
SELECT DISTINCT allsrc.owner, 'Source Search' object_type,
                allsrc.TYPE result_type, allsrc.NAME object_name
           FROM dba_source allsrc, dba_objects allo
          WHERE (INSTR (UPPER (allsrc.text), '%UNPAID') <> 0)
            AND (allo.owner = allsrc.owner)
            AND (allo.object_name = allsrc.NAME)
            AND (allo.object_type = allsrc.TYPE)
            AND (allsrc.owner IN ('POWERCARD'))