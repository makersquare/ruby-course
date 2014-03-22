require 'spec_helper'

describe 'Project' do

  it "initiates with blank employees(hash), participating(array), projects(hash), tasks(array)" do
    expect(TM::DB.instance.all_employees).to be_a(Hash)
    expect(TM::DB.instance.all_tasks).to be_a(Hash)
    expect(TM::DB.instance.all_projects).to be_a(Hash)
  end

  it "can allow access to its hashes and arrays" do
    TM::DB.instance.all_employees[:bob] = 5
    expect(TM::DB.instance.all_employees[:bob]).to eq(5)
  end

  before do
    @bob = TM::Employee.new("Bob")
    @sue = TM::Employee.new("Sue")
    @project = TM::Project.new("Kill Bill")
    @task = TM::Task.new(@project.id, "Buy gun", 8)
  end

  it "can assign projects to an employee" do
    TM::DB.instance.assign_project(@project, @bob)
    expect(TM::DB.instance.project_assigned?(@project, @bob)).to eq(true)
    expect(TM::DB.instance.project_assigned?(@project, @sue)).to eq(false)
  end

  it "can check to see if an employee is assigned to a project" do
    TM::DB.instance.project_assignments << { employee_id: @bob.employee_id,
                                              project_id: @project.id,
                                              employee: @bob,
                                              project: @project }
    expect(TM::DB.instance.project_assigned?(@project, @bob)).to eq(true)
    expect(TM::DB.instance.project_assigned?(@project, @sue)).to eq(false)
  end

  it "can assign a task to an employee & then check that assignment" do
    TM::DB.instance.assign_project(@project, @bob)
    TM::DB.instance.assign_task(@task, @bob)
    expect(TM::DB.instance.task_assigned?(@task, @bob)).to eq(true)
    expect(TM::DB.instance.task_assigned?(@task, @sue)).to eq(false)
  end

end
