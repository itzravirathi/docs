set heading off
set pagesize 0
set linesize 200
spool enable_all_trigger.sql
-- select 'ALTER TRIGGER '||TRIGGER_NAME||' ENABLE '|| '; ' from user_triggers WHERE status = 'DISABLED';
select 'ALTER TRIGGER '||TRIGGER_NAME||' ENABLE '|| '; ' from all_triggers where owner ='PCARD3UAT'
spool off
@enable_all_trigger


