def test(num, hash)
  if hash[:number]
   puts num
  else
    puts num + 5
  end
end


test(1, number: false)
=> 6

def test(hash)
  if hash[:is_number]
   puts num[:number]
  else
    puts hash[:number] + 5
  end
end

test(number: 5, is_number: true)
=> 5

Task Manager 2 is intended to provide persistence
Persistence is when your data is stored, somehow, so
when you re-open the terminal client, the projects
that were created will still be there.

Two components to the application:
  The database layer :
    The database singleton is not in charge of business logic.
    Stores data
    A database can only store 'pure' data.
    It cannot store Ruby objects
    We use hashes to represent our database

    @projects = {
      name: "do this",  (string)
      id: 5             (number)
    }

    {name: "do this", id: 5} <= should be stored in projects hash

    @projects[5] = {name: "do this", id: 5}

    ** after we have this hash, we need an interface which will
    allow us to reach into the database and work with it. All of the
    methods we are creating in the DB.rb will allow us to work with
    the entities.

    create_project - pass in data, using this data, creates a project entity
    get_project - take an ID, grabs the data, turns it into entity, return it to you
    destroy_project - takes an ID, removes it from the database
    update_project -  takes an ID and data, updates and creates an updated entity
    build_project -




  The entities layer :
    They are objects, they are instances of certain classes
    and they are temporal. Once the program dies, the entity
    ies as well. The entity is related to the business logic.
    Tasks
    Projects


  Entity relationships :
    Within entities, we have Projects and Tasks


    Projects
      Projects interact with tasks by managing the tasks
      Projects can view complete tasks
      Projects can view old tasks

      a "Has Many/Belongs" relationship
      [Projects]---E[Tasks]

      a "Many to Many" relationship
      [Students]3---E[Courses]

    Tasks
      A task can only belong to one Project





@projects = {
  1 => { :name => "do this", :id => 1}
}

@tasks = {
  1 => { :name => "t1", :id => 1, :pid =>1},
  2 => { :name => "t2", :id => 2, :pid =>1}
}


One solution is to store the @project :id in the task itself



t = db.get_task(1)


:pid = db.get_project(t.project_id)

p = db.get_project(1)
tasks array =  loop through the task hash, loop through each one, and if the project_id == the project_id in the argument, add that to the hash

create a new method =

  def get_tasks_from_project_id (p.id)

  end                                         ==> this method should return an array of entities, it's called a "database query"

