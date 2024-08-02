SELECT employees.emp_no, first_name, last_name, title, salary
  FROM employees
  LEFT JOIN (
    SELECT emp_no, MAX(salary) AS salary
      FROM salaries
      GROUP BY emp_no
  ) AS max_salaries
    USING (emp_no)
  LEFT JOIN titles USING (emp_no);
  LIMIT 5;
