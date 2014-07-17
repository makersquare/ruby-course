require 'spec_helper.rb'
describe TM::CreateEmployee do
  before do
    @db = TM.db
  end

  it "creates a new employee" do
    result = subject.run({ :name => "Brian Provost" })
    expect(result.success?).to eq(true)
    expect(result.employee.name).to eq("Brian Provost")
  end

  it "returns an error if first and last name are not inputted" do
    result = subject.run({ :name => "Brian" })
    expect(result.error?).to eq(true)
    expect(result.error).to eq :need_at_least_two_names
  end
end
