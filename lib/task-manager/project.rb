
class TM::Project
  attr_reader :name, :id
  @@id_count = 0
  def initialize(name)
    @name = name
    @@id_count += 1
    @id = @@id_count
  end

  def self.reset_id_count
    @@id_count = 0
  end
end
