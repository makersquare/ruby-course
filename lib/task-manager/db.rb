class TM::DB
  def initialize
    @db = PG.connect(host: 'localhost', dbname: 'task_manager')
    build_tables
  end

  def build_tables
    @db.exec( %Q[
            CREATE TABLE IF NOT EXISTS projects(
            id SERIAL NOT NULL PRIMARY KEY,
            name TEXT);])

    @db.exec( %Q[
            CREATE TABLE IF NOT EXISTS tasks(
            id SERIAL NOT NULL PRIMARY KEY,
            detail TEXT,
            priority INTEGER,
            complete BOOLEAN,
            pid INTEGER REFERENCES projects,
            created TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP);])
  end

  def create_project(name)
    response = @db.exec_params( %Q[
            INSERT INTO projects(name) VALUES ($1)
            RETURNING id;], [name])

    response.first["id"]
  end

  def add_task(pid, priority, detail, complete=false)
    response = @db.exec_params( %Q[
            INSERT INTO tasks(pid, priority, detail, complete) VALUES ($1,$2,$3,$4)
            RETURNING id;] ,[pid, priority, detail, complete])

    response = @db.exec("SELECT * FROM tasks WHERE id=#{response.first["id"]};")

    response = response.first
    [response["id"], response["created"]]
  end

  def update_task(id, kwargs={})
    params = []
    values = []
    n = 0
    valid_params = ["detail", "priority", "complete", "pid", "created"]

    kwargs.each do |param, value|
      if valid_params.include? param
        params << "#{param}=$#{n+=1}"
        values << value
      end
    end

    return if params == []
    params = params.join(',')
    values << id

    @db.exec_params("UPDATE tasks SET #{params} WHERE id=$#{n+=1};", values)
  end

  def update_project(id, name)
    @db.exec_params("UPDATE projects SET name=$1 WHERE id=$2;", [name, id])
  end

  def get_projects(kwargs={})

    request = "SELECT * FROM projects"
    if kwargs = {}
      response = @db.exec(request + ";")
    else
      params = []
      values = []
      n = 0
      valid_params = ["id", "name"]
      kwargs.each do |param, value|
        if valid_params.include? param
          params << "#{param}=$#{n+=1}"
          values << value
        end
      end
      params = " WHERE " + params.join(" AND ") + ";"
      response = @db.exec_params(params, values)
    end

    # Returns array of Project Objects
    response.map { |proj| TM::Project.new(proj["name"],proj["id"]) }
  end

  def get_tasks(kwargs={})

    request = "SELECT * FROM tasks"
    if kwargs = {}
      response = @db.exec(request + ";")
    else
      params = []
      values = []
      n = 0
      valid_params = ["id", "detail", "priority", "complete", "pid", "created"]
      kwargs.each do |param, value|
        if valid_params.include? param
          params << "#{param}=$#{n+=1}"
          values << value
        end
      end
      params = " WHERE " + params.join(" AND ") + ";"
      response = @db.exec_params(params, values)
    end

    # Returns array of Task Objects
    response.map { |task| TM::Task.new(task["pid"],task["detail"],task["priority"],task["complete"],task["id"],task["created"]) }
  end
end
