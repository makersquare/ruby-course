require 'spec_helper'

describe TM::ShowEmployeeProjects do
  it 'shows all projects an employee is participating in' do
    project = TM.db.create_project('a new project')
    project2 = TM.db.create_project('a new project2')
    project3 = TM.db.create_project('a new project3')
    employee = TM.db.create_employee('billy')

    assign_project1 = TM.db.assign_employee_to_project(project.id, employee.id)
    assign_project2 = TM.db.assign_employee_to_project(project2.id, employee.id)
    assign_project3 = TM.db.assign_employee_to_project(project3.id, employee.id)

    result = subject.run(eid: employee.id)

    expect(result.employee_projects.count).to eq(3)
    expect(result.employee_projects.first.project_name).to eq('a new project')
    expect(result.employee_projects.last.project_name).to eq('a new project3')

  end
end
