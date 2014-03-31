require 'spec_helper'

describe TM::ShowCompletedTasksinProject do

  it "shows completed tasks in a project" do
    # Set up our data
    proj = TM.db.create_project("Climbing Mt Everest")
    task1 = TM.db.create_task(proj.id, 'get fancy climbing boots', 5)
    task2 = TM.db.create_task(proj.id, 'grow a fancy climbing beard', 1)
    task3 = TM.db.create_task(proj.id, 'get a fancy...sherpa', 3)

    updated_task1 = TM.db.update_task(task1.id, {complete:true})
    updated_task3 = TM.db.update_task(task3.id, {complete:true})

    result = subject.run({:project_id => proj.id })
    expect(result.success?).to eq true
    expect(result.task_arr.length).to eq(2)
  end

  it "errors if the project does not exist" do
    # Set up our data
    result = subject.run({:project_id => 0})
    expect(result.error?).to eq true
    expect(result.error).to eq :project_does_not_exist
  end

  it "errors if there are no completed tasks" do
    proj = TM.db.create_project("Go to Mars")
    result = subject.run({:project_id => proj.id})

    expect(result.error?).to eq true
    expect(result.error).to eq :there_are_no_completed_tasks
  end
end
