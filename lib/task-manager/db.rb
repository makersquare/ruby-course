require 'pg'
require 'pry-byebug'
module TM
  class DB
    def initialize
      @db = PG.connect(host: 'localhost', dbname: 'task-manager')
    end

    ### CREATE ###

    def create_employee(args)
      create(args, TM::Employee)
    end

    def create_project(args)
      create(args, TM::Project)
    end

    def create_task(args)
      create(args, TM::Task)
    end

    def create(args, klass)
      keys   = args.keys.join(", ")
      values = args.values.map { |s| "'#{s}'" }.join(', ')

      command = %Q[ INSERT INTO #{klass.table_name} (#{keys})
                    VALUES (#{values})
                    returning *; ]

      execute_the(command, klass)
    end

    ### READ ###

    def get_employee(id)
      get(id, TM::Employee)
    end

    def get_project(id)
      get(id, TM::Project)
    end

    def get_task(id)
      get(id, TM::Task)
    end

    def get(id, klass)
      command = %Q[ SELECT * FROM #{klass.table_name}
                    WHERE id = #{id}; ]

      execute_the(command, klass)
    end

    ### UPDATE ###

    def update_employee(id, args)
      update(id, args, TM::Employee)
    end

    def update_project(id, args)
      update(id, args, TM::Project)
    end

    def update_task(id, args)
      update(id, args, TM::Task)
    end

    def update(id, args, klass)
      keys   = args.keys.join(", ")
      values = args.values.map { |s| "'#{s}'" }.join(', ')

      command = %Q[ UPDATE #{klass.table_name}
                    SET (#{keys}) = (#{values})
                    WHERE id = #{id}
                    returning *; ]

      execute_the(command, klass)
    end

    ### DELETE ###

    def delete_employee(id)
      delete(id, TM::Employee)
    end

    def delete_project(id)
      delete(id, TM::Project)
    end

    def delete_task(id)
      delete(id, TM::Task)
    end

    def delete(id, klass)
      command = %Q[ DELETE FROM #{klass.table_name}
                    WHERE id = #{id}
                    returning *; ]

      execute_the(command, klass)
    end

    private

    def execute_the(command, klass)
      results = @db.exec(command)

      new_results = parse_the(results).first

      klass.new( new_results )
    end

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

    private

    def db=(db)
      @db = db
    end
  end

  def self.db
    @_db_singleton ||= DB.new
  end
end
