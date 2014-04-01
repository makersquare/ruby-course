require 'spec_helper'
describe TM::CreateEmployee do
  before do
    @db = TM.DB
  end

  it "creates employee" do
    result = subject.run(:employee => 'willsmith')
    expect(result.success?).to eq true
    expect(result.employee.name).to eq 'willsmith'
  end

  it 'fails if no employee name is provided' do
    result = subject.run({:employee => ""})
    expect(result.error?).to eq true
    expect(result.error).to eq :provide_an_employee_name
  end

end
