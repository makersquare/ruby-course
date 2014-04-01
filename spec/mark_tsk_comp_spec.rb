require 'spec_helper'

describe TM::MarkTaskAsComplete do

  it "marks task as complete" do
    # Set up our data
    new_proj = TM.db.create_project("I'm on a boat")
    task = TM.db.create_task(new_proj.id, "Loot at me", 1)

    result = subject.run({:task_id => task.id})
    expect(result.success?).to eq true
    expect(result.task.complete?).to eq(true)
  end

  it "errors if the task does not exist" do
    # Set up our data
    result = subject.run({:task_id => 0})
    expect(result.error?).to eq true
    expect(result.error).to eq :task_does_not_exist
  end
end
