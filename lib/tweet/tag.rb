class Tweet::Tag
  attr_reader :tag, :id

  def initialize(tag, id)
    @tag = tag
    @id = id
  end
end
