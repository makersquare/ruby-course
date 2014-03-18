require 'spec_helper'

describe 'Project' do
  it "exists" do
    expect(TM::Project).to be_a(Class)
  end

  it 'has a name ' do
    project = TM::Project.new("New Project")
    expect(project.name).to eq("New Project")

  end
end

