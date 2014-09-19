module PM
  module Repos
    class Projects
      # TO DO
      # Complete the following method
      def all_by_employee_id(project_id)
      end

      ############################################################
      # You shouldn't have to change anything in the methods below
      ############################################################
      def save(prj)
        sql = <<-SQL
          INSERT INTO projects (description, priority)
          VALUES ($1, $2)
          RETURNING id
        SQL
        result = PM::Repos.adapter.exec(sql, [prj.description, prj.priority])
        prj.instance_variable_set :@id, result.first['id'].to_i
      end

      def find(id)
        sql = <<-SQL
          SELECT
            id,
            description,
            priority
          FROM projects
          WHERE id = $1
        SQL
        result = PM::Repos.adapter.exec(sql, [id])
        build_project(result.first)
      end

      def all
        sql = <<-SQL
          SELECT
            id,
            description,
            priority
          FROM projects
        SQL
        result = PM::Repos.adapter.exec(sql)
        result.map { |r| build_project(r) }
      end

      def build_project(data)
        p = PM::Project.new(data['description'], data['priority'])
        p.instance_variable_set :@id, data['id'].to_i
        p
      end

      def delete_all
        sql = 'DELETE FROM projects WHERE id > 0'
        PM::Repos.adapter.exec(sql)
      end
    end
  end
end
