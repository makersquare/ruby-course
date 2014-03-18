
class TM::Project
  @@project_id = 0
  attr_reader :name

  def initialize(name)
    @name = name
    @@project_id +=1
  end

  def project_id
    @@project_id
  end
end
