class Tweet::PicTweet
  attr_reader :content, :tags, :pic_url, :id

  def initialize(content, pic_url, tags, id)
    @content = content
    @tags = tags
    @pic_url = pic_url
    @id = id
  end
end
