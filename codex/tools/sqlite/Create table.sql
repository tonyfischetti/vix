PRAGMA foreign_keys=ON;
BEGIN TRANSACTION;

DROP TABLE IF EXISTS "newtable";

-- PRIMARY KEY implies UNIQUE

CREATE TABLE IF NOT EXISTS "newtable" (
  "some_id" TEXT NOT NULL PRIMARY KEY CHECK(length("some_id")=5),
) STRICT;

COMMIT;

---

-- CREATE TABLE "employees" (
-- CREATE TABLE [employees] (
-- CREATE TABLE `employees` (
CREATE TABLE employees (
  emp_no      INTEGER     NOT NULL,
  birth_date  DATE        NOT NULL,
  first_name  VARCHAR(14) NOT NULL,
  last_name   VARCHAR(16) NOT NULL,
  gender      TEXT        NOT NULL,
  hire_date   DATE        NOT NULL,
  computer_id INTEGER     NOT NULL,
  PRIMARY KEY (emp_no),
  FOREIGN KEY (computer_id) REFERENCES computers (computer_id)
);

-- or

CREATE TABLE employees (
  emp_no      PRIMARY KEY INTEGER     NOT NULL,
  birth_date  DATE        NOT NULL,
  first_name  VARCHAR(14) NOT NULL,
  last_name   VARCHAR(16) NOT NULL,
  gender      TEXT        NOT NULL,
  hire_date   DATE        NOT NULL,
  computer_id INTEGER     NOT NULL REFERENCES computers,
);

-- or

-- compound primary key
CREATE TABLE IF NOT EXISTS "contracts"(
  "plan_id"           TEXT NOT NULL	  CHECK(length("plan_id")=3),
  "site_id"           TEXT NOT NULL   CHECK(length("site_id")=5),
  "contract_status"	  TEXT NOT NULL   CHECK("contract_status"='Open' OR "contract_status"='Closed'),
  "contract_end_date"	TEXT            CHECK(length("contract_end_date")=10 OR length("contract_end_date")=0),
  FOREIGN KEY ("plan_id") REFERENCES "plans" ("plan_id"),
  FOREIGN KEY ("site_id") REFERENCES "sites" ("site_id"),
  PRIMARY KEY ("plan_id", "site_id")
) STRICT, WITHOUT ROWID;
