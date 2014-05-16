require 'spec_helper.rb'

describe PicTweet do
  it "exists" do
    expect(PicTweet).to be_a(Class)
  end

  describe "initialize" do
    it "should intialize with content, pic_url, and tags" do
      pq = PicTweet.new("hello", "imgur.com", ["#helloworld"], 0)
      expect(pq).to be_a(PicTweet)
      expect(pq.content).to eq("hello")
      expect(pq.pic_url).to eq("imgur.com")
      expect(pq.tags).to eq(["#helloworld"])
      expect(pq.id).to eq(0)
    end
  end
end
