----Exercise 1 -----
select last_name, hire_date from employees 
where department_id in (select department_id from employees where last_name = 'Zlotkey')
and last_name <> 'Zlotkey'
----Exercise 2 -----
select employee_id, last_name, salary from employees
where salary > (select AVG(salary) from employees)  order by salary ASC
---Exercise 3-----
select employee_id, last_name from employees 
where department_id in (select department_id from employees where last_name LIKE '%u%');
---Exercise 4----
select last_name, department_id, job_id from employees
where department_id in (select department_id from departments where location_id ='1700')
select e.last_name, e.department_id, e.job_id from employees e inner join departments d on e.department_id = d.department_id
where d.location_id = 1700
---Exercise 5----
select last_name, salary from employees where manager_id in
(select employee_id from employees where last_name = 'King')
select e.last_name, e.salary from employees e join employees manager on e.manager_id = manager.employee_id
where manager.last_name = 'King'
---Exercise 6----
SELECT department_id, last_name, job_id FROM employees
WHERE department_id in (SELECT department_id FROM departments WHERE department_name = 'Executive')
---Exercise 7----
SELECT employee_id, last_name, salary FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees) 
and department_id in (select department_id from employees where last_name LIKE '%u%')
---Exercise 8----
SELECT ROUND(MAX(salary),0) 'Maximum',
ROUND(MIN(salary),0) 'Minimum',
ROUND(SUM(salary),0) 'Sum',
ROUND(AVG(salary),0) 'Average'
FROM employees;
---Exercise 9---
SELECT UPPER(LEFT(last_name,1))+LOWER(SUBSTRING(last_name,2,LEN(last_name))) "Last Name", len(last_name) "Length of Name"
FROM employees
WHERE last_name like 'J%' or last_name like 'A%' or last_name like 'M%'
ORDER BY last_name;
---Exercise 10---
SELECT employee_id, last_name, salary, ROUND(salary+(salary*15.5/100),0) "New Salary"
FROM employees
---Exercise 11--- 
SELECT e.last_name, d.department_id, d.department_name
FROM employees e FULL JOIN departments d
ON e.department_id = d.department_id;
---Exercise 12---
---I do not understand exercise 12 so I do it by 2 ways
----TH1: employee who is listed should satisfy the condition: join company later than their manager and working in Toronto
SELECT e.employee_id FROM employees e JOIN employees m 
ON (e.manager_id = m.employee_id)
WHERE e.hire_date >  m.hire_date
AND e.employee_id in (SELECT e.employee_id FROM employees e JOIN departments d  
ON (e.department_id = d.department_id) JOIN   locations l
ON (d.location_id = l.location_id) WHERE l.city = 'Toronto')
----TH2: There is 2 list. list 1: employee who join company later than their manager, list 2: employee who work in Toronto.
----And I use set operator to combine 2 lists into 1 list-----
SELECT e.employee_id FROM employees e JOIN employees m 
ON (e.manager_id = m.employee_id)
WHERE e.hire_date >  m.hire_date
UNION
SELECT e.employee_id FROM employees e JOIN departments d  
ON (e.department_id = d.department_id) JOIN   locations l
ON (d.location_id = l.location_id) WHERE l.city = 'Toronto'
