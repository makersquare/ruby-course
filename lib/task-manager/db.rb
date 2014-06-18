module TM
  class DB
    def initialize
      @db = PG.connect(host: 'localhost', dbname: 'task-manager')
    end

    def create_task(data)
      # - id (auto)
      # - priority
      # - description
      # - project_id (task belongs to project)
      # - employee_id (task is assigned to an employee who is working on that project)
      # - complete (true or false)
      # - created_at (auto date/time)

      result = @db.exec(
        %Q[ INSERT INTO tasks (priority, description, project_id, employee_id, completed)
            VALUES (?,?,?,?,?)
            returning *;
          ], data
      )

      values = result.values
      args = { id:          values[0],
               priority:    values[1],
               description: values[2],
               project_id:  values[3],
               employee_id: values[4],
               completed:   values[5],
               created_at:  values[6] }
    end

    def get_task(id)
    end

    def update_task(id, data)
    end

    def delete_task(id)
    end
  end

  def self.db
    @_db_singleton ||= DB.new
  end
end
