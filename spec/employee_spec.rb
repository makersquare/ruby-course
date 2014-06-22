require 'spec_helper'

describe 'Employee' do
  let(:klass) { TM::Employee }

  let(:args) { {
    :id         => 1,
    :project_id => 1,
    :name       => 'Joe Smith'
  } }

  let(:employee) { klass.new(args) }

  it "exists" do
    expect(klass).to be_a(Class)
  end

  it "initialize accepts an arg hash with id, project_id and name" do
    expect(employee.id).to eq(1)
    expect(employee.name).to eq('Joe Smith')
  end
end
