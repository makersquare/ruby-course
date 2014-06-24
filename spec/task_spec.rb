require 'spec_helper'

describe 'Task' do
  let(:klass) { TM::Task }

  let(:args) { {
    :id          => 1,
    :description => 'Test Task',
    :priority    => 1,
    :completed   => false,
    :created_at  => Time.now
  } }

  let(:task) { klass.new(args) }

  it "exists" do
    expect(klass).to be_a(Class)
  end

  it "initialize accepts an arg hash with id, description, priority, project_id, employee_id, completed, created_at" do
    expect(task.id).to eq(1)
    expect(task.description).to eq('Test Task')
    expect(task.priority).to eq(1)
    expect(task.completed).to eq(false)
    expect(task.created_at).to be_a(Time)
  end
end
