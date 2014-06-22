require 'pg'
require 'time'
require 'pry-debugger'

module TM
  class ORM
    attr_reader :db_adaptor
    def initialize
      @db_adaptor = PG.connect(host: 'localhost', dbname: 'task-manager')
    end

    def add_tables
      table_projects = <<-SQL
        CREATE TABLE projects(
          pid SERIAL,
          name TEXT,
          creation_date TIMESTAMP,
          PRIMARY KEY(pid));
      SQL
      table_employees = <<-SQL
        CREATE TABLE employees(
          eid SERIAL,
          name TEXT,
          PRIMARY KEY(eid));
      SQL
      table_tasks = <<-SQL
        CREATE TABLE tasks(
          tid SERIAL,
          priority INTEGER,
          description TEXT,
          pid INTEGER REFERENCES projects(pid),
          eid INTEGER REFERENCES employees(eid),
          status TEXT,
          creation_date TIMESTAMP,
          PRIMARY KEY(tid));
      SQL
      table_join_projects_employees = <<-SQL
        CREATE TABLE join_projects_employees(
          jid SERIAL,
          pid INTEGER REFERENCES projects(pid),
          eid INTEGER REFERENCES employees(eid),
          PRIMARY KEY(jid));
      SQL
      @db_adaptor.exec(table_projects)
      @db_adaptor.exec(table_employees)
      @db_adaptor.exec(table_tasks)
      @db_adaptor.exec(table_join_projects_employees)
    end

    def delete_tables
      @db_adaptor.exec("DROP TABLE IF EXISTS tasks CASCADE;")
      @db_adaptor.exec("DROP TABLE IF EXISTS employees CASCADE;")
      @db_adaptor.exec("DROP TABLE IF EXISTS projects CASCADE;")
      @db_adaptor.exec("DROP TABLE IF EXISTS join_projects_employees CASCADE;")
    end

    def list_projects
      list = <<-SQL
      SELECT * FROM projects;
      SQL
      result = @db_adaptor.exec(list)
      result.values
    end

    def add_project(project)
      creation_date = Time.now
      add = <<-SQL
        INSERT INTO projects(name, creation_date)
        VALUES('#{project}', '#{creation_date}')
        RETURNING *;
      SQL
      result = @db_adaptor.exec(add)
      TM::Project.new(result[0][1])
    end

    def list_tasks
      list = <<-SQL
      SELECT * FROM tasks;
      SQL
      result = @db_adaptor.exec(list)
      result.values
    end

    def list_completed_tasks(pid)
      selection = <<-SQL
        SELECT * FROM tasks
        WHERE status = 'complete'
        AND pid = '#{pid}'
        ORDER BY creation_date ASC;
      SQL
      result = @db_adaptor.exec(selection)
      result.values
    end

    def list_incomplete_tasks(pid)
      selection = <<-SQL
        SELECT * FROM tasks
        WHERE status = 'incomplete'
        AND pid = '#{pid}'
        ORDER BY priority, creation_date;
      SQL
      result = @db_adaptor.exec(selection)
      result.values
    end

    def list_project_staffing(pid)
      selection = <<-SQL
        SELECT *
        FROM projects p, employees e
        JOIN join_projects_employees jpe
        ON e.eid = jpe.eid
      SQL
      result = @db_adaptor.exec(selection)
      result.values.select { |i| i[0][0] == pid.to_s }
    end

    def update_employee_project(pid, eid)
      add = <<-SQL
        INSERT INTO join_projects_employees(pid, eid)
        VALUES ('#{pid}', '#{eid}')
        RETURNING *;
      SQL
      result = @db_adaptor.exec(add)
      result.values
    end

    def add_task(priority, description, pid)
      creation_date = Time.now
      eid = 1
      status = 'incomplete'
      add = <<-SQL
        INSERT INTO tasks(priority, description, pid, eid, status, creation_date)
        VALUES('#{priority}', '#{description}', '#{pid}', '#{eid}', '#{status}', '#{creation_date}')
        RETURNING *;
      SQL
      result = @db_adaptor.exec(add)
      TM::Task.new(result[0][1], result[0][2], result[0][3], result[0][4], result[0][5], result[0][6])
    end

    def update_employee_task(tid, eid)
      check_employee_project(tid, eid)

      update_task = <<-SQL
        UPDATE tasks
        SET eid='#{eid}'
        WHERE tid='#{tid}'
        RETURNING *;
      SQL

      result = @db_adaptor.exec(update_task)
      result.values[0]
    end

    def check_employee_project(tid, eid)
      #Confirm employee has been assigned to the project before they can be assigned tasks
      list_join = <<-SQL
        SELECT *
        FROM projects p
        JOIN join_projects_employees jpe
        ON p.pid = jpe.pid
        JOIN employees e
        ON e.eid = '#{eid}'
      SQL
      result = @db_adaptor.exec(list_join)
      result.values
      task_pid = TM.orm.list_tasks[0][3] #project ID column

      update_employee_project(task_pid, eid)
    end

    def update_complete(pid, tid)
      update = <<-SQL
        UPDATE tasks
        SET status='complete'
        WHERE pid='#{pid}' AND tid='#{tid}'
        RETURNING *;
      SQL
      result = @db_adaptor.exec(update)
      result.values
    end

    def list_employees
      selection = <<-SQL
        SELECT * FROM employees;
      SQL
      result = @db_adaptor.exec(selection)
      result.values
    end

    def add_employee(name)
      add = <<-SQL
        INSERT INTO employees(name)
        VALUES('#{name}')
        RETURNING *;
      SQL
      result = @db_adaptor.exec(add)
      TM::Employee.new(result[0][1], result[0][2])
    end

    def list_employee_projects(eid)
      list_join = <<-SQL
        SELECT *
        FROM projects p
        JOIN join_projects_employees jpe
        ON p.pid = jpe.pid
        JOIN employees e
        ON e.eid = '#{eid}'
      SQL
      result = @db_adaptor.exec(list_join)
      result.values
    end

    def list_employee_tasks(eid)
      selection = <<-SQL
        SELECT *
        FROM tasks
        JOIN projects
          ON projects.pid = tasks.pid
        JOIN employees
          ON employees.eid = tasks.eid
      SQL
      result = @db_adaptor.exec(selection)
      result.values.select { |i| i[4] == eid.to_s }
    end

    def list_employee_history(eid)
      list_employee_tasks(eid).select { |i| i if i[5] == 'complete'}
    end

    # Helper methods for setting instance variables
    def show_task
      list_tasks.last
    end

    def show_project
      list_projects.last
    end

    def show_employee
      list_employees.last
    end
  end

  def self.orm
    @__orm_instance ||= ORM.new
  end
end
