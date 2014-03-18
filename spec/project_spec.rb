require 'spec_helper'

describe 'Project' do
  it "exists" do
    expect(TM::Project).to be_a(Class)
  end

  it "initializes with a name" do
    project = TM::Project.new("Bird Watching")
    expect(project.name).to eq("Bird Watching")
  end
end
