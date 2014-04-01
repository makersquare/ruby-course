require 'spec_helper'
describe TM::EmployeeDetails do
  before do
    @db = TM.DB
  end

  it "shows completed tasks for employee" do
    employee = @db.create_employee('bob')
    task = @db.create_task('desc')

    project = @db.create_project('project_name')
    assign = @db.assign_task(task.id, employee.id)
    assign_to_proj = @db.assign_emp_to_project(employee.id, project.id)
    result = subject.run(:eid => employee.id)
    expect(result.success?).to eq true
    # expect(result.).to eq
  end

  it 'fails if no id is provided' do
    result = subject.run({:eid => nil})
    expect(result.error?).to eq true
    expect(result.error).to eq :provide_a_emp_id
  end

end
