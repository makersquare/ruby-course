require 'spec_helper'
describe TM::ShowEmployees do
  before do
    @db = TM.DB
  end

  it "shows employees tasks" do
    project = @db.create_project('project_name')
    emp = @db.create_employee('willsmith')
    emp2 = @db.create_employee('me')
    assign = @db.assign_emp_to_project(emp.id, project.id)
    assign2 = @db.assign_emp_to_project(emp2.id, project.id)
    result = subject.run(:pid => project.id)
    expect(result.success?).to eq true
    expect(result.employees.last).to eq emp2.id
  end

  it 'fails if no id is provided' do
    result = subject.run({:pid => nil})
    expect(result.error?).to eq true
    expect(result.error).to eq :provide_a_project_id
  end

  it 'fails if project does not exist' do
    project = @db.create_project('project_name')
    result = subject.run(pid: 10000)
    expect(result.error?).to eq true
    expect(result.error).to eq :project_doesnt_exist
  end
end
