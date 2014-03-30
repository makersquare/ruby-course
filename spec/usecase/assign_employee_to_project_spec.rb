require 'spec_helper'

describe TM::AssignEmployeeToProject do
  it 'successfully assigns an employee to a project' do
    project = TM.db.create_project('a new project')
    employee1 = TM.db.create_employee('bob')
    employee2 = TM.db.create_employee('bill')
    employee3 = TM.db.create_employee('jim')

    result = subject.run(pid: project.id, eid: employee1.id)

    expect(result.success?).to eq(true)
    expect(result.employee.name).to eq('bob')
    expect(result.project.project_name).to eq('a new project')

  end
end
