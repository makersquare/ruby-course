require 'spec_helper'

describe 'Project' do
  it "exists" do
    expect(TM::Project).to be_a(Class)
  end
  it "should be initialized with a name" do
    blue = TM::Project.new("name")
    expect(blue.name).to eq("name")
  end
  it "should be initialized with a unique id" do
    project_one = TM::Project.new('one')
  end
end
