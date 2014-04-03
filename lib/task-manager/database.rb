require 'singleton'

module TM

  # The singleton getter
  def self.db
    @__db_instance ||= DB.new(@app_db_name)
  end

  # This allows us to set our database name in both our
  # spec_helper.rb and also our client code.
  # You MUST set this before the **first time** you call your singleton getter.
  def self.db_name=(db_name)
    @app_db_name = db_name
  end

  class DB

    def initialize(db_name)
      raise StandardError.new("Please set TM.db_name") if db_name.nil?

      # This creates a connection to our database file
      @sqlite = SQLite3::Database.new(db_name)
      @projects = {}
      @tasks = {}
      @employees = {}
    end

    ##########################
    ## Project CRUD Methods ##
    ##########################

    # The OLD method
    # def all_projects
    #   @projects.values
    # end
    #
    # The new, SQL method
    def all_projects
      result = @sqlite.execute("SELECT * FROM projects")

      # Here we convert our array of **data arrays** into an array of convenient Project objects.
      # Due to Ruby's implicit returns, the new array gets returned.
      result.map do |row|
        # `row` is an array of data. Example: [1, 'My Project Name']
        # You can discover the column order by looking at your table schema
        # For example:
        #   $ sqlite3 tm_test.db
        #   sqlite> .schema projects
        #
        proj = TM::Project.new(row[1])
        proj.id = row[0]
        proj
      end
    end

    # The OLD method
    # def create_project(name)
    #   proj = TM::Project.new(name)
    #   proj
    # end
    #
    # The new, SQL method
    def create_project(name)
      proj = TM::Project.new(name)
      @sqlite.execute("INSERT INTO projects (name) VALUES (?);", name)

      # This is needed so other code can access the id of the project we just created
      proj.id = @sqlite.execute("SELECT last_insert_rowid()")[0][0]

      # Return a Project object, just like in the old method
      proj
    end

    # The OLD method
    # def get_project(pid)
    #   @projects[pid]
    # end
    #
    # The new, SQL method
    def get_project(pid)
      # Pro Tip: Always try SQL statements in the terminal first
      rows = @sqlite.execute("SELECT * FROM projects WHERE id = ?", pid)

      # Since we are selecting by id, and ids are UNIQUE, we can assume only ONE row is returned
      data = rows.first

      # Create a convenient Project object based on the data given to us by SQLite
      project = TM::Project.new(data[1])
      project.id = data[0]
      project
    end

    #######################
    ## Task CRUD Methods ##
    #######################

    def all_tasks
      @tasks.values
    end

    def create_task(pid, desc, priority)
      pid = pid.to_i
      priority = priority.to_i

      proj = @projects[pid]

      added_task = TM::Task.new(pid, desc, priority)

      @tasks[added_task.id] = added_task

      added_task
    end

    def get_task(tid)
      @tasks[tid]
    end

    def get_remaining_tasks_for_project(pid)
      @tasks.values.select {|t| t.project_id == pid }
    end

    def update_task(tid, attrs)
      task = @tasks[tid]
      task.description = attrs[:description] if attrs[:description]
      task.priority = attrs[:priority] if attrs[:priority]
      task
    end

    ##############################
    ## SQL Database Interaction ##
    ##############################

    def clear_all_records
      @sqlite.execute("DELETE FROM projects")
      @sqlite.execute("DELETE FROM tasks")
    end

  end
end