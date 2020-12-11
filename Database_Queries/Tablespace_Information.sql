-- Table Space object 
SELECT -- owner,
        TABLESPACE_NAME,
        PARTITION_NAME,
        SEGMENT_NAME,
       DECODE (partition_name,
               NULL, segment_name,
               segment_name || ':' || partition_name
              ) objectname,
       segment_type objecttype, NVL (BYTES / 1048576, 0) sizemb,
       NVL (initial_extent, 0) initialext, NVL (next_extent, 0) nextext,
       NVL (EXTENTS, 0) NUMEXTENTS, NVL (MAX_EXTENTS, 0) "MAXEXTENTS"
      FRoM dba_segments
 WHERE   1=1  
-- AND TABLESPACE_NAME = 'PCARD3UAT_DAT_BO_M01'  
-- and DECODE (PARTITION_NAME,null, SEGMENT_NAME,SEGMENT_NAME || ':' || PARTITION_NAME) like '%10MAR%' 
and PARTITION_NAME like 'LOG_PATH%'
AND SEGMENT_TYPE IN ( 'TABLE','TABLE PARTITION')
           order by 2 ;
/


SELECT count(1) FROM PCARD3UAT.DISCOUNT;

SELECT -- owner,
        TABLESPACE_NAME,
        PARTITION_NAME,
        SEGMENT_NAME,
       DECODE (partition_name,
               NULL, segment_name,
               SEGMENT_NAME || ':' || PARTITION_NAME
              ) objectname, B.OWNER,
       segment_type objecttype, NVL (BYTES / 1048576, 0) sizemb,
       NVL (initial_extent, 0) initialext, NVL (next_extent, 0) nextext,
       NVL (extents, 0) numextents, NVL (max_extents, 0) "MAXEXTENTS"
  FROM  --  USER_SEGMENTS 
      dba_segments A , dba_objects B
 WHERE   1=1  
AND TABLESPACE_NAME ='PCARD3UAT_DAT_BO_M01' --like 'PCARD3UAT\_%' ESCAPE '\'
AND DECODE (PARTITION_NAME,NULL, SEGMENT_NAME,SEGMENT_NAME || ':' || PARTITION_NAME) = B.object_name and b.object_type = 'TABLE'
-- and PARTITION_NAME in ('CR_TRANSACTION')
AND DECODE (PARTITION_NAME,NULL, SEGMENT_NAME,SEGMENT_NAME || ':' || PARTITION_NAME) IN
('ADDRESSES_TABLE',
'CARD',
'CR_LOAN',
'LOG_PATH_2_HIST',
'LOG_PATH_3_HIST',
'SHADOW_ACCOUNT',
'SHADOW_ACCOUNT_ADDENDUM',
'CR_TERM',
'CLIENT',
'TANDEM_BALANCE_MASTER',
'CR_DAILY_BALANCE_BUF',
'CR_DAILY_BALANCE_BUF',
'CR_TRANSACTION_NEW_TRXS',
'SHINSEI_STAT_BALANCE',
'SHINSEI_STAT_CONTRACT',
'AUTHO_ACTIVITY_ADM',
'BALANCE_DELIVERY_1_ACCOUNT',
'BALANCE_DELIVERY_2_ACCOUNT',
'CYCLE_CUTOFF_LIST',
'DAILY_CHANGE_TRANSACTION')
AND SEGMENT_TYPE = 'TABLE'
           ORDER BY 7 desc,4 ;
/
SELECT * FROM DBA_OBJECTS WHERE OBJECT_NAME ='CARD'
/
-- Date base free space

SELECT   tablespace_name "Tablespace", COUNT (BYTES) "Pieces",
         MIN (BYTES) "Min", ROUND (AVG (BYTES)) "Average", MAX (BYTES) "Max",
         SUM (BYTES) "Total"
    FROM SYS.DBA_FREE_SPACE  WHERE TABLESPACE_NAME IN
(
'PCARD2UAT_DAT_BO_M01',
'PCARD2UAT_DAT_BO_M02',
'PCARD2UAT_DAT_BO_M03',
'PCARD2UAT_DAT_BO_M05',
'PCARD2UAT_DAT_BT_M01',
'PCARD2UAT_DAT_FE_M01',
'PCARD2UAT_DAT_P_M01'
)
GROUP BY tablespace_name
order BY tablespace_name;

select * from table_space_info where pct_free < 30 -- where tablespace_name like 'STAGING\_%' ESCAPE '\'
;

-- Table Space Information

SELECT   a.tablespace_name, 
          ROUND (a.bytes_alloc / 1024 / 1024, 2) megs_alloc,
         ROUND (NVL (b.bytes_free, 0) / 1024 / 1024, 2) megs_free, 
         ROUND ((a.bytes_alloc - NVL (b.bytes_free, 0)) /1024/1024,2 ) megs_used,
         ROUND ((NVL (b.bytes_free, 0) / a.bytes_alloc) * 100, 2) pct_free, 
         100 - ROUND ((NVL (b.bytes_free, 0) / a.bytes_alloc) * 100, 2) pct_used,
         ROUND (maxbytes / 1048576, 2) MAX 
         FROM (SELECT   f.tablespace_name, SUM (f.BYTES) bytes_alloc,  
                        SUM (DECODE (f.autoextensible,'YES', f.maxbytes,'NO', f.BYTES)) maxbytes 
                        FROM V_DATA_FILES f
                              --   DBA_data_files f 
               GROUP BY tablespace_name) a,
         (SELECT   f.tablespace_name, SUM (f.BYTES) bytes_free  
                FROM DBA_FREE_SPACE f
                GROUP BY tablespace_name) b
   WHERE A.TABLESPACE_NAME = B.TABLESPACE_NAME(+)
  --AND A.TABLESPACE_NAME  like '%P_M01'
        --like 'STAGING\_%' ESCAPE '\';
       order by 3 desc ;
     
     
       PUBLIC	DBA_DATA_FILES
PUBLIC	V_DATA_FILES
SYS	V_DATA_FILES
       
select * from all_objects where object_name like '%FREE_SPACE%'       

SELECT   h.tablespace_name,
         ROUND (SUM (h.bytes_free + h.bytes_used) / 1048576, 2) megs_alloc,
         ROUND (  SUM ((h.bytes_free + h.bytes_used) - NVL (p.bytes_used, 0))/ 1048576,2) megs_free,
         ROUND (SUM (NVL (p.bytes_used, 0)) / 1048576, 2) megs_used,
         ROUND (  (  SUM (  (h.bytes_free + h.bytes_used) - NVL (p.bytes_used, 0) ) / SUM (h.bytes_used + h.bytes_free) ) * 100, 2 ) pct_free,
           100 - ROUND (  (  SUM (  (h.bytes_free + h.bytes_used) - NVL (p.bytes_used, 0) ) / SUM (h.bytes_used + h.bytes_free) ) * 100,2 ) pct_used,
         ROUND (f.maxbytes / 1048576, 2) MAX
    FROM V$TEMP_SPACE_HEADER h,  V$TEMP_EXTENT_POOL p, sys.dba_temp_files f
     WHERE p.file_id(+) = h.file_id  AND p.tablespace_name(+) = h.tablespace_name AND f.file_id = h.file_id AND f.tablespace_name = h.tablespace_name
    -- AND f.tablespace_name like 'STAGING%'
GROUP BY h.tablespace_name, f.maxbytes
ORDER BY 4 desc;

select * from all_objects where object_name like '%SPACE_HEADER%'


select * from V$TEMP_EXTENT_POOL



--- Tablespace File name information
SELECT file_name, ROUND (BYTES / 1024 / 1024, 2), blocks, autoextensible,
       NVL (increment_by, 0), maxbytes, maxblocks, status, maxblocks, file_id
  
  
  select * FROM sys.dba_data_files
 WHERE tablespace_name = 'STAGING_PR_DAT_PMT_M';
 
-- Table space Free space
SELECT   tablespace_name "Tablespace", COUNT (BYTES) "Pieces",
         MIN (BYTES) "Min", ROUND (AVG (BYTES)) "Average", MAX (BYTES) "Max",
         SUM (BYTES) "Total"
    FROM SYS.dba_free_space
   WHERE tablespace_name = 'STAGING_IND_BAL'
GROUP BY tablespace_name


 
 -- Table Space Extents
 SELECT   segment_type, owner,
         DECODE (partition_name,
                 NULL, segment_name,
                 segment_name || ':' || partition_name
                ) objectname,
         file_id fileid, block_id blockid, blocks, BYTES
    FROM dba_extents
   WHERE tablespace_name = 'STAGING_IND_BAL'
ORDER BY 3, 4

-- Table Properties
SELECT flashback_on
  FROM SYS.v_$tablespace
 WHERE NAME = 'STAGING_IND_BAL'
 
 SELECT *
  FROM dba_tablespaces
 WHERE tablespace_name = 'STAGING_IND_BAL'
 
 -- Script
 SELECT VALUE
  FROM v$option
 WHERE parameter = 'Objects'
 
 --- Date Base file
 
 
 SELECT   t.tablespace_name "Tablespace", 'Datafile' "File Type",
         t.status "Status",
         ROUND ((d.max_bytes - NVL (f.sum_bytes, 0)) / 1024 / 1024,
                2
               ) "Used MB",
         ROUND (NVL (f.sum_bytes, 0) / 1024 / 1024, 2) "Free MB",
         t.initial_extent "Initial Extent", t.next_extent "Next Extent",
         t.min_extents "Min Extents", t.max_extents "Max Extents",
         t.pct_increase "Pct Increase",
         SUBSTR (d.file_name, 1, 80) "Datafile name"
    FROM (SELECT   tablespace_name, file_id, SUM (BYTES) sum_bytes
              FROM dba_free_space
          GROUP BY tablespace_name, file_id) f,
         (SELECT   tablespace_name, file_name, file_id, MAX (BYTES) max_bytes
              FROM dba_data_files
          GROUP BY tablespace_name, file_name, file_id) d,
         dba_tablespaces t
   WHERE t.tablespace_name = d.tablespace_name
     AND f.tablespace_name(+) = d.tablespace_name
     AND f.file_id(+) = d.file_id
GROUP BY t.tablespace_name,
         d.file_name,
         t.initial_extent,
         t.next_extent,
         t.min_extents,
         t.max_extents,
         t.pct_increase,
         t.status,
         d.max_bytes,
         f.sum_bytes
UNION ALL
SELECT   h.tablespace_name, 'Tempfile', t.status,
         ROUND (SUM (NVL (p.bytes_used, 0)) / 1048576, 2),
         ROUND (  SUM ((h.bytes_free + h.bytes_used) - NVL (p.bytes_used, 0))
                / 1048576,
                2
               ),
         -1,                                                 -- initial extent
            -1,                                              -- initial extent
               -1,                                              -- min extents
                  -1,                                           -- max extents
                     -1,                                       -- pct increase
                        t.file_name
    FROM SYS.v_$temp_space_header h,
         SYS.v_$temp_extent_pool p,
         SYS.dba_temp_files t
   WHERE p.file_id(+) = h.file_id
     AND p.tablespace_name(+) = h.tablespace_name
     AND h.file_id = t.file_id
     AND h.tablespace_name = t.tablespace_name
GROUP BY h.tablespace_name, t.status, t.file_name
ORDER BY 1, 4 DESC


