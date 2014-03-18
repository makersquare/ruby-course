require 'spec_helper'

describe 'Project' do
  it "exists" do
    expect(TM::Project).to be_a(Class)
  end

  it "has a name" do
    test = TM::Project.new("Test")
    expect(test.name).to eq("Test")
  end

  it "has an id with the name" do
    test = TM::Project.new("Test")
    expect(test.name).to eq("Test")

    id = (0...8).map {(65+rand(26)).chr}.join
    expect(TM::Project.id).not_to be_empty
  end

end
