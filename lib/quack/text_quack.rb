class Quack::TextQuack
  attr_reader :content, :tags, :id
  def initialize(content, tags, id)
    @content = content
    @tags = tags
    @id = id
  end
end