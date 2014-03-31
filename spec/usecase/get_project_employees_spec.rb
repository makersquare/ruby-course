require 'spec_helper'

describe TM::GetProjectEmployees do
  it 'returns all the employees associated to a project by pid' do
      project = TM.db.create_project('a new project')
      employee1 = TM.db.create_employee('bob')
      employee2 = TM.db.create_employee('bill')
      employee3 = TM.db.create_employee('jim')
      assign_employee1 = TM.db.assign_employee_to_project(project.id, employee1.id)
      assign_employee3 = TM.db.assign_employee_to_project(project.id, employee3.id)

      result = subject.run(pid: project.id)
      expect(result.success?).to eq(true)
      expect(result.project_employees.first.name).to eq('bob')
      expect(result.project_employees.last.name).to eq('jim')
  end
  it 'returns an error if the project doesn\'t exist' do
    result = subject.run(pid: 9999)
    expect(result.error?).to eq(true)
    expect(result.error).to eq :project_does_not_exist
  end
  it 'returns a message letting the user know there are no employees assigned to this project' do
    project = TM.db.create_project('a newer project')
    result = subject.run(pid: project.id)
    expect(result.error?).to eq(true)
    expect(result.error).to eq :no_employees_assigned_to_this_project
  end
end
