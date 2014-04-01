require 'spec_helper'

describe TM::CreateTask do

  it "creates a new task" do
    # Set up our data
    new_proj = TM.db.create_project("Being a Boss Coder")
    result = subject.run({:project_id => new_proj.id, :description => "Code all the things", :priority => 2})
    expect(result.success?).to eq true
    expect(result.project.name).to eq("Being a Boss Coder")
    expect(result.task.description).to eq("Code all the things")
  end
end
