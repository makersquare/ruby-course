class TM::Project
attr_reader :name, :id
attr_accessor :tasks

  @@project_counter = 0

  def initialize(name)
    @name = name
    @@project_counter += 1
    @id = @@project_counter
  end

end
