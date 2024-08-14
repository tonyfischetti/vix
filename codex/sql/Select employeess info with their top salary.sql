-- sql, subquery, join, using, limit, group by, joining to a subquery, three table join, 3 table join

SELECT * FROM employees LIMIT 2;
-- ┌────────┬────────────┬────────────┬───────────┬────────┬────────────┐
-- │ emp_no │ birth_date │ first_name │ last_name │ gender │ hire_date  │
-- ├────────┼────────────┼────────────┼───────────┼────────┼────────────┤
-- │ 10001  │ 1953-09-02 │ Georgi     │ Facello   │ M      │ 1986-06-26 │
-- │ 10002  │ 1964-06-02 │ Bezalel    │ Simmel    │ F      │ 1985-11-21 │
-- └────────┴────────────┴────────────┴───────────┴────────┴────────────┘

SELECT * FROM salaries LIMIT 2;
-- ┌────────┬────────┬────────────┬────────────┐
-- │ emp_no │ salary │ FROM_date  │  to_date   │
-- ├────────┼────────┼────────────┼────────────┤
-- │ 10001  │ 60117  │ 1986-06-26 │ 1987-06-26 │
-- │ 10001  │ 62102  │ 1987-06-26 │ 1988-06-25 │
-- └────────┴────────┴────────────┴────────────┘

SELECT * FROM titles LIMIT 2;
-- ┌────────┬─────────────────┬────────────┬────────────┐
-- │ emp_no │      title      │ FROM_date  │  to_date   │
-- ├────────┼─────────────────┼────────────┼────────────┤
-- │ 10001  │ Senior Engineer │ 1986-06-26 │ 9999-01-01 │
-- │ 10002  │ Staff           │ 1996-08-03 │ 9999-01-01 │
-- └────────┴─────────────────┴────────────┴────────────┘



SELECT emp_no, first_name, last_name, title, salary
  FROM employees
  LEFT JOIN (
    SELECT emp_no, MAX(salary) AS salary
      FROM salaries
      GROUP BY emp_no) AS each_employees_max_salary USING (emp_no)
  LEFT JOIN titles USING (emp_no)
  LIMIT 5;

