require 'spec_helper'

describe TM::ShowRemainingTasksinProject do

  it "returns an array of the project's incomplete tasks" do
    # Set up our data
    new_proj = TM.db.create_project("Being a Lumberjack")
    task1 = TM.db.create_task(new_proj.id, 'work all night', 2)
    task2 = TM.db.create_task(new_proj.id, 'sleep all day', 5)
    task3 = TM.db.create_task(new_proj.id, 'wear fancy dresses', 3)
    updated_tsk2 = TM.db.update_task(task2.id, {complete:true})

    result = subject.run({:project_id => new_proj.id})
    expect(result.success?).to eq true
    expect(result.task_arr.length).to eq(2)
    expect(result.task_arr[0].description).to eq('work all night')
  end

  it "errors if the project does not exist" do
    # Set up our data
    result = subject.run({:project_id => 0})
    expect(result.error?).to eq true
    expect(result.error).to eq :project_does_not_exist
  end
end
