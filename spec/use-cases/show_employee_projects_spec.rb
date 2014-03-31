require 'spec_helper'
describe TM::ShowProjects do
  before do
    @db = TM.DB
  end

  it "show projects assigned to eid" do
    emp = @db.create_employee('bob')
    proj = @db.create_project('project_name')
    proj2 = @db.create_project('project2_name')
    assign = @db.assign_emp_to_project(emp.id, proj.id)
    assign2 = @db.assign_emp_to_project(emp.id, proj2.id)

    result = subject.run(:eid => emp.id)
    binding.pry
    expect(result.success?).to eq true
    expect(result.projects.count).to eq 2
  end

  it 'fails if employee does not exist' do
    result = subject.run(:eid => nil)
    expect(result.error?).to eq true
    expect(result.error).to eq :employee_doesnt_exist
  end
end
