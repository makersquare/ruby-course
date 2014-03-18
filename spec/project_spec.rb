require 'spec_helper'
require './lib/task-manager/project.rb'

describe 'Project' do
  before do
    @new_project = TM::Project.new("New Project")
  end

  it "exists" do
    expect(TM::Project).to be_a(Class)
  end

  it "initializes with a name" do
    result = @new_project.name
    expect(result).to eq("New Project")
  end

  it "initializes with an id number that is readable" do
    expect { @new_project.id}.to_not raise_error
    puts @new_project.id
  end

end

