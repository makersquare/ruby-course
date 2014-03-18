require 'spec_helper'

describe 'Task' do
  it "exists" do
    expect(TM::Task).to be_a(Class)
  end

  before do
    TM::Task.task_id = 1
    @buy_gun = TM::Task.new(2, "Go buy a gun", 7)
  end

  it "can be created with a project_id, description, and priority number" do
    expect(@buy_gun.project_id).to eq(2)
    expect(@buy_gun.description).to eq("Go buy a gun")
    expect(@buy_gun.priority).to eq(7)
  end

  it "can be marked as complete, specified by id"

  end

end
