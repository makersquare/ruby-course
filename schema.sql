
-- Table: projects
CREATE TABLE projects ( 
    id          SERIAL PRIMARY KEY
                       NOT NULL
                       UNIQUE,
    description TEXT,
    priority    TEXT 
);

-- Table: employees
CREATE TABLE employees ( 
    id     SERIAL PRIMARY KEY
                  NOT NULL
                  UNIQUE,
    name   TEXT,
    email  TEXT,
    salary INT
);

-- Table: memberships
-- TODO: Create the 'memberships table'.

CREATE TABLE memberships ( 
    id           SERIAL PRIMARY KEY
                        NOT NULL
                        UNIQUE,
    employee_id  INT    references employees(id),
    project_id   INT    references projects(id),
    type         TEXT
);