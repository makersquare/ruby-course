module Tweet
  class PostTextTweet

    # Create this run method that accomplishes what the name of this
    # method insists
    #
    # As a return value send back a hash that has the following key/value pairs
    #   :success? => whether or not the method completed successfully
    #   :error => If it wasn't successful, add this key with
    #     the value being a string explaining the error
    #   any other key value pairs that show the results of this
    #
    # Example results:
    #  {:success? => false, :error => "Content was blank"}
    #  {:success? => true,
    #   :tweet => tweet(tweet object),
    #   :tags => tags (array of tag objects)
    #  }
    #
    # Once you're comfortable with that, return an OpenStruct instead of a hash
    def run
    end

  end
end