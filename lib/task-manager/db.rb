require 'pg'
require 'time'
require 'pry-byebug'
module TM
  class DB
    def initialize(dbname = 'task-manager')
      @conn = PG.connect(host: 'localhost', dbname: dbname)
      build_tables
    end

    def build_tables
      @conn.exec(%Q[
        CREATE TABLE IF NOT EXISTS projects(
          id serial NOT NULL PRIMARY KEY,
          name text
        )])

      @conn.exec(%Q[
        CREATE TABLE IF NOT EXISTS employees(
          id serial NOT NULL PRIMARY KEY,
          project_id integer REFERENCES projects(id),
          name text
        )])

      @conn.exec(%Q[
        CREATE TABLE IF NOT EXISTS tasks(
          id serial NOT NULL PRIMARY KEY,
          project_id integer REFERENCES projects(id),
          employee_id integer REFERENCES employees(id),
          priority integer,
          description text,
          completed boolean DEFAULT FALSE,
          created_at timestamp NOT NULL DEFAULT current_timestamp
        )])
    end

    ### CREATE ###

    def create(sklass, args)
      keys   = args.keys.join(", ")
      values = args.values.map { |s| "'#{s}'" }.join(', ')

      command = %Q[ INSERT INTO #{sklass} (#{keys})
                    VALUES (#{values})
                    returning *; ]

      execute_the(command, sklass)
    end

    ### READ ###

    # def get(sklass, id)
    #   command = %Q[ SELECT * FROM #{sklass}
    #                 WHERE id = #{id}; ]

    #   execute_the(command, sklass)
    # end

    ### FIND ###
    def find(sklass, args)
      command = "SELECT * FROM #{sklass}"

      unless args.empty?
        command += " WHERE "
        args_ary = [ ]
        args.each do |k,v|
          args_ary.push("#{k} = #{v}")
        end

        command += args_ary.join(" AND ")
      end

      command += ";"

      execute_the(command, sklass)
    end

    # def something(sklass, args)
    #   command = %Q[ SELECT employees.id, employees.name, employees.email
    #                 FROM employees, projects, project_employees
    #                 WHERE project_employees.project_id = #{args[:project_id]}]

    #   execute_the(command, sklass)
    # end

    ### UPDATE ###

    def update(sklass, id, args)
      keys   = args.keys.join(", ")
      values = args.values.map { |s| "'#{s}'" }.join(', ')

      command = %Q[ UPDATE #{sklass}
                    SET (#{keys}) = (#{values})
                    WHERE id = #{id}
                    returning *; ]

      execute_the(command, sklass)
    end


    # recruit(sklass, {'project_id' => project_id, 'employee_id' => employee_id})
    # def recruit(sklass, args)
    #   keys   = args.keys.join(", ")
    #   values = args.values.map { |s| "'#{s}'" }.join(', ')

    #   command = %Q[ INSERT INTO #{sklass} (#{keys})
    #                 VALUES (#{values})
    #                 returning *; ]

    #   execute_the(command, sklass)
    # end

    ### DELETE ###

    def delete(sklass, id)
      command = %Q[ DELETE FROM #{sklass}
                    WHERE id = #{id}
                    returning *; ]

      execute_the(command, sklass)
    end

    private

    def get_klass(sklass)
      {projects:  TM::Project,
       employees: TM::Employee,
       tasks:     TM::Task }[sklass.to_sym]
    end

    def execute_the(command, sklass)
      klass = get_klass(sklass)

      results = @conn.exec(command)

      new_results = parse_the(results)

      begin
        return_objects = [ ]
        new_results.each do |result|
          return_objects.push( klass.new(result) )
        end

        return_objects
      rescue
        nil
      end
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

    def conn
      @conn
    end

    def conn=(conn)
      @conn = conn
    end
  end

  def self.db
    @_db_singleton ||= DB.new
  end
end
