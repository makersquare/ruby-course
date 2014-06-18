require 'pg'

module TM
  class DB
    def initialize
      @db = PG.connect(host: 'localhost', dbname: 'task-manager')
    end

    def create_employee(data)
      # - id (auto)
      # - name
      # - email

      command = %Q[ INSERT INTO employees (name, email)
                    VALUES ($1, $2)
                    returning *; ]

      results = @db.exec_params( command, data )

      new_results = parse_the(results)

      new_results.first
    end

    def create_project(data)
      # - id (auto)
      # - name (text)
      # - completed (boolean)
      # - created_at (auto date/time)

      command = %Q[ INSERT INTO projects (name, completed)
                    VALUES ($1, $2)
                    returning *; ]

      results = @db.exec_params( command, data )

      new_results = parse_the(results)

      new_results.first
    end

    def create_task(data)
      # - id (auto)
      # - priority
      # - description
      # - project_id (task belongs to project)
      # - employee_id (task is assigned to an employee who is working on that project)
      # - completed (true or false)
      # - created_at (auto date/time)

      command = %Q[ INSERT INTO tasks (priority, description, project_id, employee_id, completed)
                    VALUES ($1, $2, $3, $4, $5)
                    returning *; ]

      result = @db.exec_params( command, data )

      result.first
    end

    def get_task(id)
    end

    def update_task(id, data)
    end

    def delete_task(id)
    end

    private

    def parse_the(results)
      presults = [ ]

      results.each do |result|
        presult = result.inject({}){|hash,(k,v)| hash[k.to_sym] = v; hash}

        presult[:id         ] = result[:id         ].to_i
        presult[:priority   ] = result[:priority   ].to_i if result[:priority]
        presult[:project_id ] = result[:project_id ].to_i if result[:project_id]
        presult[:employee_id] = result[:employee_id].to_i if result[:employee_id]
        if result[:completed]
          presult[:completed] = (result[:completed] == 'f' ? false : true)
        end
        presult[:created_at ] = Time.parse( result[:created_at] ) if result[:created_at]

        presults << presult
      end

      presults
    end
  end

  def self.db
    @_db_singleton ||= DB.new
  end
end
