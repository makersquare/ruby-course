
class TM::Project

attr_reader :name
attr_accessor :tasklist, :projectid

  def initialize(name, projectid )
    @projectid = projectid
    @name = name
    @tasklist = []
  end


  def add_task_to_project(theTaskToAdd)
    @tasklist << theTaskToAdd
    theTaskToAdd

  end



end


# array = [task1, task2, task3]

# array.sort_by {|x| -x.priority}
