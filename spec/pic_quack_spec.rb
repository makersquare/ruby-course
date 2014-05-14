require 'spec_helper.rb'

describe PicQuack do
  it "exists" do
    expect(PicQuack).to be_a(Class)
  end

  describe "initialize" do
    it "should intialize with content, pic_url, and tags" do
      pq = PicQuack.new("hello", "imgur.com", ["#helloworld"], 0)
      expect(pq).to be_a(PicQuack)
      expect(pq.content).to eq("hello")
      expect(pq.pic_url).to eq("imgur.com")
      expect(pq.tags).to eq(["#helloworld"])
      expect(pq.id).to eq(0)
    end
  end
end