require 'spec_helper'

describe 'Project' do
  it "exists" do
    expect(TM::Project).to be_a(Class)
  end

  it "allows project to be created with name optional but autmatically given unique id" do
    project = TM::Project.new("hello")
    expect(project.id).to eq(1)
    expect(project.name).to eq("hello")
  end
end
