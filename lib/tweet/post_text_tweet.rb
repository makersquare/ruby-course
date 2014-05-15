module Tweet
  class PostTextTweet < Command
    def run(inputs)
      # Create the text tweet in the database
      t = Tweet.db.create_text_tweet(content: inputs[:content])
      if t.nil?
        failure(:didnt_create_tweet)
      end
      
      # Make sure all tags are created
      tags = []
      inputs[:tags].each do |tag|
        t = Tweet.db.get_or_create_tag(tag)
        if t.nil?
          failure(:tag_doesnt_exist)
        end
        tags << t
      end

      # Build relationships between tags and tweets
      tags.each do |tag|
        res = Tweet.db.create_text_tweet_tag(t, tag)
        if res.nil?
          failure(:relationship_not_built)
      end

      success :tweet => t, :tags => tags
    end
  end
end


result = PostTextTweet.run(inputs)

if result.success?
  puts "The id is #{result.tweet_id}"
else
  puts "It failed because #{result.error}"
end