require 'spec_helper.rb'

describe TextQuack do
  it "exists" do
    expect(TextQuack).to be_a(Class)
  end

  describe "initialize" do
    it "initializes with text and list of tags" do
      tq = TextQuack.new("hello", ["#helloworld"], 0)
      expect(tq.content).to eq("hello")
      expect(tq.tags).to eq(["#helloworld"])
      expect(tq.id).to eq(0)
    end
  end
end