class Tweet::SQLDB

  def initialize
    @db = SQLite3::Database.new "test.db"
  end

  def build_text_tweet(data)
  end

  def create_text_tweet(data)
  end

  def get_or_create_tag(data)
  end

  def get_tag(id)
  end

  def create_text_tweet_tag(tt_id, tag_id)
  end

  def get_text_tweets_from_tag(tag)
  end

  def build_pic_tweet(data)
  end
  
  def create_pic_tweet(data)
  end

  def create_pic_tweet_tag(pt_id, tag_id)
  end

  def get_pic_tweets_from_tag(tag)
  end
end
