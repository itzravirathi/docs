
-- list of indexs

SELECT *   FROM user_indexes where table_name  = '%CUST';
----------------------------------


SELECT   I.index_name,
         J.COLUMN_NAME, 
         I.table_name, 
         I.tablespace_name, 
         I.table_owner, 
         I.status, 
         I.uniqueness,
         I.index_type, 
         TEMPORARY, 
         I.partitioned, 
         I.funcidx_status,
         I.join_index, 
         I.dropped
    FROM SYS.ALL_indexes i, ALL_ind_columns J
   WHERE 1 = 1 and J.index_name = I.INDEX_NAME  -- AND  I.table_name like '%CARD_XSALES_LOAN_TSUTAYA%'
    and I.tablespace_name ='STAGING_PR_DAT_M'
ORDER BY index_name;


SELECT  *    FROM all_ind_columns
   WHERE 1=1 AND 
   index_name = 'CARDS_TYPE_INFO_IDX1'
ORDER BY table_name;

-- Index information time ETC

SELECT *
  FROM SYS.user_objects
 WHERE object_name like  '%DUMMY%' AND object_type = 'INDEX'
 
----------------------------------




----------------------------------
Timestamp: 12:55:35.788
SELECT index_name "Index Name", index_type "Index Type",
       uniqueness "Uniqueness", status "Status",
       table_owner || '.' || table_name "Table", table_type "Table Type",
       tablespace_name "Tablespace", BUFFER_POOL "Buffer Pool",
       INITCAP (partitioned) "Partitioned",
       DECODE (TEMPORARY, 'N', 'No', 'Yes') "Temporary",
       ini_trans "Initial Transactions", max_trans "Max Transactions",
       initial_extent "Initial Extent Size", next_extent "Next Extent Size",
       min_extents "Minimum Extents", max_extents "Maximum Extents",
       pct_increase "Percent Increase", pct_free "Percent Free",
       FREELISTS "Freelists", freelist_groups "Freelist Groups",
       DEGREE "Degree", INSTANCES "Instances", last_analyzed "Last Analyzed",
       blevel "BLevel", leaf_blocks "Leaf Blocks",
       distinct_keys "Distinct Keys",
       avg_leaf_blocks_per_key "Avg Leaf Blocks Per Key",
       avg_data_blocks_per_key "Avg Data Blocks Per Key",
       clustering_factor "Clustering Factor", num_rows "Num Rows",
       sample_size "Sample Size", GENERATED "Generated",
       DECODE (join_index, 'NO', 'No', 'Yes') "Join Index"
  FROM SYS.dba_indexes
 WHERE owner = 'POWERCARD' AND index_name = 'ACTIONS_TYPE_CODE_PK'
 
 
 --- ===============================================================
 SELECT *
  FROM SYS.dba_indexes i
 WHERE owner = 'POWERCARD'
   AND index_type <> 'LOB'
   AND index_type <> 'IOT - TOP'
   AND index_name = 'ACTIONS_TYPE_CODE_PK'
----------------------------------
Timestamp: 12:57:11.117
SELECT   index_owner, index_name, column_name, column_length, table_owner,
         table_name, column_position, descend
    FROM SYS.dba_ind_columns
   WHERE index_owner = 'POWERCARD' AND index_name = 'ACTIONS_TYPE_CODE_PK'
ORDER BY index_owner, index_name, column_position
----------------------------------
Timestamp: 12:57:11.695
SELECT *
  FROM SYS.dba_join_ind_columns
 WHERE index_owner = 'POWERCARD' AND index_name = 'ACTIONS_TYPE_CODE_PK'
----------------------------------
Timestamp: 12:57:12.273
SELECT   ie.index_owner, ie.index_name, ie.column_expression, ic.descend,
         ic.column_name
    FROM SYS.dba_ind_expressions ie, SYS.dba_ind_columns ic
   WHERE ie.index_owner = ic.index_owner
     AND ie.index_name = ic.index_name
     AND ie.table_owner = ic.table_owner
     AND ie.table_name = ic.table_name
     AND ie.column_position = ic.column_position
     AND ic.index_owner = 'POWERCARD'
     AND ic.column_name LIKE 'SYS_NC%'
     AND ie.index_name = 'ACTIONS_TYPE_CODE_PK'
ORDER BY ie.index_name, ic.column_position
 
 
 
 -- Linkup Code
 
 SELECT   db_link, username, HOST, created, owner, '<pwd>' PASSWORD
    FROM SYS.dba_db_links
   WHERE owner IN ('POWERCARD', 'PUBLIC')
ORDER BY 1