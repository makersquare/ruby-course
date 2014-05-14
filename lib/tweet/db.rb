class Tweet::DB
  attr_reader :text_tweets, :tags, :text_tweet_tags

  def initialize
    @text_tweets = {}
    @next_tt_id = 0
    @tags = {}
    @next_tag_id = 0
    @text_tweet_tags = {}
    @text_tweet_tags_counter = 0
  end

  def create_text_tweet(data)
    data[:id] = @next_tt_id
    @next_tt_id += 1

    # Runs get_or_create_tag on each tag passed in
    data[:tags].each do |tag|
      tag_obj = get_or_create_tag({tag: tag})
      # binding.pry
      create_text_tweet_tag(data[:id], tag_obj.id)
    end

    data.delete(:tags)
    @text_tweets[data[:id]] = data
    TextTweet.new(data[:content], nil, data[:id])
    
  end

  def get_or_create_tag(data)
    # binding.pry
    existing_tag = tags.select {|id, tag| tag[:tag] == data[:tag]}.first
    # binding.pry
    if existing_tag
      data = existing_tag.last
    else
      data[:id] = @next_tag_id
      @next_tag_id += 1
      @tags[data[:id]] = data
    end
    Tag.new(data[:tag], data[:id])
  end

  def get_tag(id)
    data = @tags[id]
    Tag.new(data[:tag], data[:id])
  end

  # For creating a text_tweet_tag
  # Expects two inputs: tt_id and tag_id representing the ids of the tweet and 
  # the tag
  # Adds the text_tweet_tag to the database
  # Returns the id of the new text_tweet_tag

  def create_text_tweet_tag(tt_id, tag_id)
    id = @text_tweet_tags_counter
    data = {tt_id: tt_id, tag_id: tag_id, id: id}
    @text_tweet_tags[id] = data
    @text_tweet_tags_counter += 1
    return id
  end
end

module Tweet
  def self.db
    @__db_instance ||= DB.new
  end
end
