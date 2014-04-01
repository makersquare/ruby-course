require_relative "../spec_helper.rb"

describe TM::ProjectShow do
  before do
    @db = TM.db
  end

  it "show a remaining task for project, based on pid" do
    # Set up our data
    # task = @db.create_task('make me a sandwich')
    # emp = @db.create_employee('Bob')
              # subject = TM::ProjectShow refer to class
    proj = @db.create_project("fitness")
    task1 = @db.create_task(proj.id,{:descr=>"fishing",:priority_num=>3})
    task2 = @db.create_task(proj.id,{:descr=>"hunting",:priority_num=>4})

    result = subject.run({ :pid => proj.id })

    expect(result.success?).to eq true
                                      # proj.name, but the string of it
    expect(result.project.name).to eq("fitness")

    remaining_task_descr = result.remaining_tasks.map do |task|
      task.descr
    end

    expect(remaining_task_descr).to eq(["fishing","hunting"])
  end

  it "errors if the project does not exist" do
    # Set up our data
    result = subject.run({:pid=>9999})

    expect(result.error?).to eq true
    expect(result.error).to eq :project_does_not_exist
  end
end


