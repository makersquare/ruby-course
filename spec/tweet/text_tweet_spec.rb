require 'spec_helper.rb'

describe TextTweet do
  it "exists" do
    expect(TextTweet).to be_a(Class)
  end

  describe "initialize" do
    it "initializes with text and list of tags" do
      tt = TextTweet.new("hello", ["#helloworld"], 0)
      expect(tt.content).to eq("hello")
      expect(tt.tags).to eq(["#helloworld"])
      expect(tt.id).to eq(0)
    end
  end
end
