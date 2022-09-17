create table emp_scd1(
emp_dim_key number(5), 
ename varchar(15),
job varchar(15),
sal number(6),
comm number(5),
hiredate date,
mgr_name varchar(15),
deptno number(5),
dname varchar(15),
loc varchar(15),
inserted_date date,
inserted_by varchar(35),
updated_date date,
updated_by varchar(35));

drop table emp_scd1;


select * from EMP_SCD1;
select * from emp;
//
create or replace procedure sp_scd1 as
cursor cu_scd1 is
select empno,ename,job,mgr,hiredate,sal,comm,d.deptno,dname,loc from emp e,dept d 
where e.deptno=d.deptno;
c int;
c_eno int;
begin 
    for i in cu_scd1 loop
    begin
        select count(*) into c
        from emp_scd1
        where emp_dim_key=i.empno ;
          
       
        
        if c=0 then
            insert into emp_scd1 values(i.empno,i.ename,i.job,i.sal,i.comm,i.hiredate,
            (select e2.ename from emp e1,emp e2 where e1.mgr=e2.empno and e1.empno=i.empno),
            i.deptno,i.dname,i.loc,sysdate,user,null,null);
       
        else
        begin
            select emp_dim_key into c_eno
            from emp_scd1
            where (deptno!=i.deptno OR sal!=i.sal OR job!=i.job OR comm!=i.comm) AND ename=i.ename and hiredate=i.hiredate;
            
            
            update emp_scd1 
            set updated_date=sysdate,updated_by=user ,sal=i.sal , job=i.job ,comm=i.comm, deptno=i.deptno
            where emp_dim_key=c_eno;
            
            exception
            when no_data_found then
            dbms_output.put_line('no update');
       end;     
        
       end if;
       end;
       end loop;
       end;
/ 
exec sp_scd1;

select * from emp_scd1;
truncate table emp_scd1;

insert into emp values(2222,'kumar','hr',7934,sysdate,3800,null,30);
commit;

update emp
set sal=sal+8
WHERE deptno=10;

COMMIT;
SELECT * FROM EMP;



