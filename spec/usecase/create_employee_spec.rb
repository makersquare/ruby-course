require 'spec_helper'
describe TM::CreateEmployee do
  it 'throws an error if no name is provided' do
    result = subject.run(name: nil)
    expect(result.error?).to eq(true)
    expect(result.error).to eq(:no_name_provided)
  end

  it 'successfully creates an employee' do
    result = subject.run(name: 'bob')
    expect(result.employee.name).to eq('bob')

  end
end
