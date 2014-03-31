require 'spec_helper'

describe TM::ListEmployees do
  xit 'returns a warning letting the user know there are no employees' do
    result = subject.run
    expect(result.error?).to eq(true)
    expect(result.employees).to be_nil
    expect(result.error).to eq(:no_employees_created)
  end
  it 'lists all employees' do
    employee = TM.db.create_employee('bob')
    employee = TM.db.create_employee('bill')
    employee = TM.db.create_employee('jim')
    result = subject.run
    expect(result.employees.count).to be > 2
    expect(result.employees.first.name).to eq('bob')
    expect(result.employees.last.name).to eq('jim')
  end
end
