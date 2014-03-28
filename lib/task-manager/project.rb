class TM::Project
attr_reader :name, :pid
attr_accessor :tasks

  @@project_counter = 0

  def initialize(name)
    @name = name
    @@project_counter += 1
    @pid = @@project_counter
  end

end
