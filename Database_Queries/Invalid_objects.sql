-------------------------------------------------------------------------------------------------

SELECT count(1) from user_indexes where status<>'VALID' and status<>'N/A';

 

SELECT count(1) from user_ind_partitions where status<>'USABLE';

 

SELECT count(1) from user_triggers where status<>'ENABLED';

 

SELECT count(1) from user_CONSTRAINTS where status<>'ENABLED';

 

SELECT object_type,count(1) FROM user_objects WHERE status <> 'VALID' group by object_type;

-------------------------------------------------------------------------------------------------

 

DECLARE
l_str VARCHAR2(2000);
BEGIN
FOR i IN (SELECT * FROM all_constraints where OWNER = 'PCARD3UAT' and STATUS = 'ENABLED')
LOOP
BEGIN
l_str := 'ALTER TABLE '|| I.OWNER||'.'||i.table_name ||' DISABLE CONSTRAINT '||i.constraint_name;
EXECUTE IMMEDIATE l_str;
-- DBMS_OUTPUT.PUT_LINE(l_str);
EXCEPTION
WHEN OTHERS THEN
NULL;
END;
END LOOP;
END;
/
DECLARE
l_str VARCHAR2(2000);
BEGIN
FOR i IN (select * from ALL_INDEXES where TABLE_OWNER = 'PCARD3UAT' and STATUS <> 'UNUSABLE')
LOOP
BEGIN
l_str := 'ALTER INDEX '|| I.OWNER||'.'||i.INDEX_NAME ||'  UNUSABLE';
EXECUTE IMMEDIATE l_str;
-- DBMS_OUTPUT.PUT_LINE(l_str);
EXCEPTION
WHEN OTHERS THEN
NULL;
END;
END LOOP;
END;
/

ALTER TABLE PCARD3UAT.PCRD_LETTER_REQ_000002 DISABLE CONSTRAINT PK_PCRD_LETTER_REQ_000002

SELECT * FROM all_constraints where OWNER = 'PCARD3UAT' and STATUS = 'ENABLED'

select * from ALL_INDEXES where TABLE_OWNER = 'PCARD3UAT' and STATUS <> 'UNUSABLE'

 PCARD3UAT.PK_CR_LOAN UNUSABLE;
 
 ALTER INDEX STAGING_TS.HOLIDAYS_IDX_DAY_OFF  UNUSABLE