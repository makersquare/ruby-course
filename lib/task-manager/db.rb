require 'pg'
require 'pry-byebug'
module TM
  class DB
    def initialize
      @db = PG.connect(host: 'localhost', dbname: 'task-manager')
    end

    ### Employee ###

    def create_employee(args) # {'name' => 'joe', 'email' => 'joe@email.com'}
      # - id (auto)
      # - name
      # - email

      command = %Q[ INSERT INTO employees (name, email)
                    VALUES ($1, $2)
                    returning *; ]

      data = [ args['name'], args['email'] ]
      # binding.pry
      results = @db.exec_params( command, data )

      new_results = parse_the(results).first

      TM::Employee.new( new_results )
    end

    def get_employee(id)
      command = %Q[ SELECT * FROM employees
                    WHERE id = $1; ]

      data = [id]

      results = @db.exec_params( command, data )

      new_results = parse_the(results).first

      TM::Employee.new( new_results )
    end

    def update_employee(id, args) # {'name' => 'joe', 'email' => 'joe@email.com'}
      command = %Q[ UPDATE employees
                    SET ($1) = ($2)
                    WHERE id = $3; ]

      keys   = args.keys.join(", ")
      values = args.values.map { |s| "'#{s}'" }.join(', ')

      data = [keys, values, id]
      binding.pry
      results = @db.exec_params( command, data )

      new_results = parse_the(results).first

      TM::Employee.new( new_results )
    end

    def delete_employee(id)
      command = %Q[ DELETE FROM employees
                    WHERE id = $1
                    returning *; ]

      data = [id]

      results = @db.exec_params( command, data )

      new_results = parse_the(results).first

      TM::Employee.new( new_results )
    end

    ### Project ###

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

    ### Task ###

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

        presult[:id         ] = presult[:id         ].to_i
        presult[:priority   ] = presult[:priority   ].to_i if presult[:priority]
        presult[:project_id ] = presult[:project_id ].to_i if presult[:project_id]
        presult[:employee_id] = presult[:employee_id].to_i if presult[:employee_id]
        if presult[:completed]
          presult[:completed] = (presult[:completed] == 'f' ? false : true)
        end
        presult[:created_at ] = Time.parse( presult[:created_at] ) if presult[:created_at]

        presults << presult
      end

      presults
    end
  end

  def self.db
    @_db_singleton ||= DB.new
  end
end
