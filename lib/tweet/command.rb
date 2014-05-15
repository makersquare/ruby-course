class Command
  def self.run(inputs)
    self.new.run(inputs)
  end

  def failure(err_sym)
    CommandFailure.new(error: err_sym)
  end

  def success(data={})
    CommandSuccess.new(data)
  end
end

class CommandFailure < OpenStruct
  def success?
    false
  end
end

class CommandSuccess < OpenStruct
  def success?
    true
  end
end

result = PostTextTweet.run({content: "Look at this", tags: ["tag1", "tag2"]})


if result.success?
  puts "YAY this worked"
  puts "The tweet's id is #{result.tags}"
else
  puts "OH no this didn't"
  puts "It failed because #{result.error}"
end
