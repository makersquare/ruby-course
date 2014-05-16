require 'spec_helper'

describe Tag do
  it "exists" do
    expect(Tag).to be_a(Class)
  end

  describe "initialize" do
    it "initializes with tag and id" do
      t = Tag.new("this", 0)
      expect(t).to be_a(Tag)
      expect(t.id).to eq(0)
      expect(t.tag).to eq("this")
    end
  end
end