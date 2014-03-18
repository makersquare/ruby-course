
class TM::Project

attr_reader :name
attr_accessor :tasklist, :projectid

  def initialize(name, projectid )
    @projectid = projectid
    @name = name
    @tasklist = []
  end


  def add(task)
    @tasklist << task

  end

end
