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
          name text
        )])

      @conn.exec(%Q[
        CREATE TABLE IF NOT EXISTS employeeprojects(
          id serial NOT NULL PRIMARY KEY,
          employee_id integer REFERENCES employees(id),
          project_id integer REFERENCES projects(id)
        )])

      @conn.exec(%Q[
        CREATE TABLE IF NOT EXISTS tasks(
          id serial NOT NULL PRIMARY KEY,
          priority integer,
          description text,
          completed boolean DEFAULT FALSE,
          created_at timestamp NOT NULL DEFAULT current_timestamp
        )])

      @conn.exec(%Q[
        CREATE TABLE IF NOT EXISTS employeetasks(
          id serial NOT NULL PRIMARY KEY,
          employee_id integer REFERENCES employees(id),
          task_id integer REFERENCES tasks(id)
        )])

      @conn.exec(%Q[
        CREATE TABLE IF NOT EXISTS projecttasks(
          id serial NOT NULL PRIMARY KEY,
          project_id integer REFERENCES projects(id),
          task_id integer REFERENCES tasks(id)
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

    ### READ / FIND ###
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

    # def find_employee_tasks(sklass, args)
    #   employee_id = args['employee_id']
    #   completed   = args['completed']

    #   command = %Q[ SELECT * FROM #{sklass}, employeetasks
    #                 WHERE employee_id = #{employee_id}
    #                 AND completed = #{completed} ]


    #   # unless args.empty?
    #   #   command += " WHERE "
    #   #   args_ary = [ ]
    #   #   args.each do |k,v|
    #   #     args_ary.push("#{k} = #{v}")
    #   #   end

    #   #   command += args_ary.join(" AND ")
    #   # end

    #   command += ";"

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

    ### DELETE ###

    def delete(sklass, id)
      command = %Q[ DELETE FROM #{sklass}
                    WHERE id = #{id}
                    returning *; ]

      execute_the(command, sklass)
    end

    private

    # def get_klass(sklass)
    #   {projects:  TM::Project,
    #    employees: TM::Employee,
    #    tasks:     TM::Task }[sklass.to_sym]
    # end

    def execute_the(command, sklass)
      # klass = get_klass(sklass)
      results = @conn.exec(command)

      new_results = parse_the(results)

      # begin
      #   return_objects = [ ]
      #   new_results.each do |result|
      #     return_objects.push( klass.new(result) )
      #   end

      #   return_objects
      # rescue
      #   nil
      # end
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

    def conn
      @conn
    end

    def conn=(conn)
      @conn = conn
    end

    def drop_tables
      @conn.exec(%Q[ DROP TABLE IF EXISTS projecttasks CASCADE; ])
      @conn.exec(%Q[ DROP TABLE IF EXISTS employeetasks CASCADE; ])
      @conn.exec(%Q[ DROP TABLE IF EXISTS tasks CASCADE; ])
      @conn.exec(%Q[ DROP TABLE IF EXISTS employeeprojects CASCADE; ])
      @conn.exec(%Q[ DROP TABLE IF EXISTS employees CASCADE; ])
      @conn.exec(%Q[ DROP TABLE IF EXISTS projects CASCADE; ])
    end
  end

  def self.db
    @_db_singleton ||= DB.new
  end
end
