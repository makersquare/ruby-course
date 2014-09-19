module PM
  module Repos
    class Employees
      # TO DO
      # Complete the following method
      def all_by_project_id(project_id)
      end

      ############################################################
      # You shouldn't have to change anything in the methods below
      ############################################################
      def save(emp)
        sql = <<-SQL
          INSERT INTO employees (name, email, salary)
          VALUES ($1, $2, $3)
          RETURNING id
        SQL
        result = PM::Repos.adapter.exec(sql, [emp.name, emp.email, emp.salary])
        emp.instance_variable_set :@id, result.first['id'].to_i
      end

      def find(id)
        sql = <<-SQL
          SELECT
            id,
            name,
            email,
            salary
          FROM employees
          WHERE id = $1
        SQL
        result = PM::Repos.adapter.exec(sql, [id])
        build_employee(result.first)
      end

      def all
        sql = <<-SQL
          SELECT
            id,
            name,
            email,
            salary
          FROM employees
        SQL
        result = PM::Repos.adapter.exec(sql)
        result.map { |r| build_employee(r) }
      end

      def build_employee(data)
        e = PM::Employee.new(data['name'], data['email'], data['salary'])
        e.instance_variable_set :@id, data['id'].to_i
        e
      end

      def delete_all
        sql = 'DELETE FROM employees WHERE id > 0'
        PM::Repos.adapter.exec(sql)
      end
    end
  end
end
