
class TM::Project
  attr_reader :id

  def initialize(name)
    @name = name
    @id = self.class.generate_id
  end

  def self.generate_id
    tmp = @@id_counter ||= 0
    @@id_counter +=1
    tmp
  end

end
