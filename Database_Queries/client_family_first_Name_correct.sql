declare

cursor C1 is 
select rowid,client_code from pcard1pr.client where family_name is null or first_name is null;
           
family_n varchar2(100):=null;
first_n varchar2(100):=null;

rec_count number:=0;
begin

for c1_rec in c1 loop

  select lname , fname into family_n ,first_n from (
    SELECT cust_no1 cust_no,
       TRIM(REPLACE(REPLACE(SUBSTR(INDV_CUST_KNA_NM1,1,INSTR(INDV_CUST_KNA_NM1,' ')-1),' '),' ')) LNAME,
       TRIM(REPLACE(REPLACE(SUBSTR(INDV_CUST_KNA_NM1,INSTR(INDV_CUST_KNA_NM1,' ')),' '),' ')) FNAME
       FROM staging_pr.tbl_mf020036 A where a.cust_no1 = c1_rec.client_code  
       union
      SELECT cust_no2 cust_no,
       TRIM(REPLACE(REPLACE(SUBSTR(INDV_CUST_KNA_NM2,1,INSTR(INDV_CUST_KNA_NM2,' ')-1),' '),' ')) LNAME,
       TRIM(REPLACE(REPLACE(SUBSTR(INDV_CUST_KNA_NM2,INSTR(INDV_CUST_KNA_NM2,' ')),' '),' ')) FNAME
       FROM staging_pr.tbl_mf020036 A where a.cust_no2 = c1_rec.client_code
      ) where rownum <=1;
  
    update client set family_name = family_n, first_name = first_n where rowid = c1_rec.rowid;
    
    rec_count:=rec_count+1;
    if rec_count > 5000 then
      commit;
      rec_count:= 0;
    end if;
    
end loop;
commit;
end;

/*
select cust_no,lname,fname from (
SELECT cust_no1 cust_no,
       TRIM(REPLACE(REPLACE(SUBSTR(INDV_CUST_KNA_NM1,1,INSTR(INDV_CUST_KNA_NM1,' ')-1),' '),' ')) LNAME,
       TRIM(REPLACE(REPLACE(SUBSTR(INDV_CUST_KNA_NM1,INSTR(INDV_CUST_KNA_NM1,' ')),' '),' ')) FNAME
       FROM staging_pr.tbl_mf020036 A where a.cust_no1 = '100269670343'    
       union
SELECT cust_no2 cust_no,
       TRIM(REPLACE(REPLACE(SUBSTR(INDV_CUST_KNA_NM2,1,INSTR(INDV_CUST_KNA_NM2,' ')-1),' '),' ')) LNAME,
       TRIM(REPLACE(REPLACE(SUBSTR(INDV_CUST_KNA_NM2,INSTR(INDV_CUST_KNA_NM2,' ')),' '),' ')) FNAME
       FROM staging_pr.tbl_mf020036 A where a.cust_no2 = '100269670343'    
) B  
      
update card a set family_name = (select family_name from client b where a.client_code = b.client_code) ,
 first_name  = (select first_name from client b where a.client_code = b.client_code)
where family_name is null or first_name is null

*/

/