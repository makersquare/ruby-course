require 'pry-byebug'
# USE THE DEBUGGER TO EXAMINE PROBLEMS

module PM
  module Repos
    class Memberships
      # TO DO
      def create(project, employee, type)
      end

      def delete(project, employee)
      end

      def delete_all
        sql = 'DELETE FROM memberships WHERE id > 0'
        PM::Repos.adapter.exec(sql)
      end
    end
  end
end
