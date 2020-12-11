set heading off
set pagesize 0
set linesize 200
spool enable_all_fk.sql
select 'alter table '||table_name||' enable constraint '|| constraint_name ||'; ' from user_constraints where status='DISABLED';
spool off
@enable_all_fk
