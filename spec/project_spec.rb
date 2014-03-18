require 'spec_helper'

describe 'Project' do
  before do
    @project = TM::Project.new("New Project")
  end


  it "exists" do
    expect(TM::Project).to be_a(Class)
  end

  it 'has a name ' do
    expect(@project.name).to eq("New Project")
  end

  it 'initializes with a unique id' do

    expect(@project.id).to eq(@project.object_id)
  end



end

