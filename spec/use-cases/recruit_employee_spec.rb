require 'spec_helper'
describe TM::RecruitEmployees do
  before do
    @db = TM.DB
  end

  it "shows employees tasks" do
    project = @db.create_project('project_name')
    emp = @db.create_employee('willsmith')
    result = subject.run(:eid => emp.id, :pid => project.id)
    expect(result.success?).to eq true
    expect(result.employee.name).to eq 'willsmith'
  end

  it 'fails if no pid is provided' do
    result = subject.run({:eid => 1})
    expect(result.error?).to eq true
    expect(result.error).to eq :provide_a_project_id
  end

  it 'fails if project does not exist' do
    emp = @db.create_employee('willsmith')
    result = subject.run(:eid => emp.id, :pid => 10000)
    expect(result.error?).to eq true
    expect(result.error).to eq :project_doesnt_exist
  end

  it 'fails if employee does not exist' do
    project = @db.create_project('project_name')
    result = subject.run(:eid => nil, :pid => project.id)
    expect(result.error?).to eq true
    expect(result.error).to eq :employee_doesnt_exist
  end
end
