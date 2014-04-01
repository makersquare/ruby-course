require_relative "../spec_helper.rb"

describe TM::ProjectHistory do
  before do
    @db = TM.db
  end

  it "shows completed task for project, based on pid" do
    proj = @db.create_project("study")
    task = @db.create_task(proj.id,{:descr=>"homework",:priority_num=>5})
    task1 = @db.create_task(proj.id,{:descr=>"studygroup",:priority_num=>3})

    expect(task.complete).to eq false
    @db.mark_task_complete(task.id)
    expect(task.complete).to eq true
    @db.mark_task_complete(task1.id)

    result = subject.run({:pid => proj.id})

    expect(result.success?).to eq true
    expect(result.project.name).to eq "study"
    expect(result.completed_task).to eq [task,task1]

    # taskarray = @db.completed_task_proj()
  end

  it "errors if the project does not exist" do
    result = subject.run({:pid => 32423})

    expect(result.error?).to eq true
    expect(result.error).to eq (:project_does_not_exist)

  end
end
