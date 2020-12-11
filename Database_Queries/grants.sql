select * from ALL_TAB_PRIVS  where GRANTEE ='PCARDUAT' and grantor ='SYS' -- in ('STAGING','PUBLIC')

-- Give grants from one db to another DB.
select  'GRANT ' || privilege ||' ON ' || TABLE_NAME || ' TO ' || DECODE(GRANTEE,'STAGING_PR','STAGING',GRANTEE)|| ';'  
from all_TAB_PRIVS where table_name in  (
select  object_name from all_objects where owner = 'PCARD1PR' --and object_type in('PACKAGE','PACKAGE BODY')
) AND GRANTOR = 'PCARD1PR' and GRANTEE in ('STAGING_PR','PUBLIC') AND TABLE_NAME = 'PCRD_SHINSEI_INCOMING_TRX_FILE'
order by  table_name,grantee


-- Create synonyms from one to another DB.

select COUNT(1) -- 'CREATE SYNONYM '|| TABLE_NAME ||' FOR ' || 'STAGING_PR.'||TABLE_NAME||';' 
from all_synonyms where owner in('STAGING')

select  * from all_objects where owner = 'STAGING' AND OBJECT_NAME ='CARD'
synonym_name
select distinct object_type from all_objects


select * from ALL_TAB_PRIVS  where grantee in ('STAGING_PR','PCARD1PR') and grantor ='SYS' order by  grantee 

select * from all_synonyms where owner in('STAGING')




CREATE OR REPLACE  PUBLIC SYNONYM name  FOR pcard3uat.name

select 'CREATE OR REPLACE SYNONYM ' || SYNONYM_NAME || ' FOR pcard3uat.'||table_name || ' ;' from all_synonyms where owner ='STAGING' 

SELECT *  FROM PCARD1PR.powercard_globals 
WHERE variable_name like 'DEFAULT_%_TABLESPACE'


update  PCARD1PR.powercard_globals   set VARIABLE_VALUE ='PCARD1PR_IND_BT_M01'
WHERE variable_name like 'DEFAULT_%_TABLESPACE' and VARIABLE_VALUE ='PCARDUAT_IND_BT_M01'

commit

GRANT SELECT ON CR_TRANS_DEBIT_ORDER_PARAM TO STAGING_PR;

select 'GRANT SELECT ON '||object_name||' TO STAGING_PR;' from user_objects where object_type in ('VIEW','TABLE');

grant all on  PCARD1PR.AUTHO_ACTIVITY_ADM_PR to staging_pr

select
