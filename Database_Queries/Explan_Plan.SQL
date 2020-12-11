EXPLAIN PLAN SET STATEMENT_ID = 'test1' 
INTO SQLN_EXPLAIN_PLAN
FOR
SELECT * FROM tbl_mf01901 a
            WHERE 1 = 1
              AND EXISTS (
                     SELECT 'x'
                       FROM tbl_mf01903 b
                      WHERE vld_agn_hndl_susp_date IS NULL
                        AND vld_agn_merch_number = TRIM ('06007991')
                        AND a.seq000300 = b.sls_cntr_cnt_number)
              AND a.seq001700 IS NULL
              AND a.seq020800 IS NULL
              and a.seq020900 is null
;

SELECT  lpad(' ',2*(level-1))||operation operation,
        options,
        object_name,
        position
FROM SQLN_EXPLAIN_PLAN
START WITH id=0
AND statement_id = 'CC71D8CB'
CONNECT BY prior id = parent_id
AND statement_id = 'CC71D8CB';