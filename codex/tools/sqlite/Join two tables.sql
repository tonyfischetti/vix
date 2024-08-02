SELECT employees.emp_no, first_name, last_name, title, salary
  FROM employees
  LEFT JOIN salaries ON employees.emp_no=salaries.emp_no
  LEFT JOIN titles ON employees.emp_no=titles.emp_no;

SELECT employees.emp_no, first_name, last_name, title, salary
  FROM employees
  LEFT JOIN salaries USING (emp_no)
  LEFT JOIN titles USING (emp_no);
