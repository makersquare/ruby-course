require 'spec_helper'

describe TM::CreateEmployee do

  it "creates a new employee" do
    # Set up our data
    result = subject.run({:name => "Tunde"})
    expect(result.success?).to eq true
    expect(result.employee.name).to eq("Tunde")
  end

end
