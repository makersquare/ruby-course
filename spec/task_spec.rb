require 'spec_helper'

describe 'Task' do
  it "exists" do
    expect(TM::Task).to be_a(Class)
  end

  it "can be initialized with project id, description, priority number, and id" do
    TM::Task.project_id_counter = 1
    blue = TM::Task.new(1, "eat lunch", 5)
    expect(blue.project_id).to eq(1)
    expect(blue.description).to eq("eat lunch")
    expect(blue.priority_number).to eq(5)
    expect(blue.id).to eq(1)
  end
end
