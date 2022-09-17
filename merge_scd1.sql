create sequence sq_dim_key;
---Merge Statement:
/
create or replace procedure sp_scd11 as
begin
    merge into emp_scd11 et
    using (select ename, job, hiredate, sal, comm, e.deptno, d.dname
            from emp e,dept d
            where  e.deptno = d.deptno)e
    on (et.ename = e.ename and
        et.hiredate = e.hiredate)
    when MATCHED  then  
        update 
        set et.sal = e.sal,
        et.deptno = e.deptno,
        et.job = e.job,
        et.updated_date = sysdate,
        et.updated_by = user
        where et.ename = e.ename and
        et.hiredate = e.hiredate and 
        (et.sal <> e.sal or et.deptno <> e.deptno or et.job <> e.job)
    when not matched then
        insert (et.emp_dim_key,et.ename, et.job, et.sal, et.comm, et.hiredate, et.deptno, et.dname, et.inserted_date, et.inserted_by)
        values (sq_dim_key.nextval,e.ename,  e.job,  e.sal,  e.comm,  e.hiredate,  e.deptno,  e.dname,  sysdate,user);
end;
/
exec sp_scd11;

select * from emp_scd11;
select * from emp;
update emp
set ename='SAGAR'
where sal=80000;


exec dejul22_abdul.emp_target;
commit;