require 'spec_helper'

describe 'Task' do
  it "exists" do
    expect(TM::Task).to be_a(Class)
  end

  describe '.initialize' do
    it "requires a description, project_id and priority_number" do
      expect { TM::Task.new }.to raise_error(ArgumentError)
      expect { TM::Task.new("A new task", 0, 1) }.not_to raise_error
    end
  end
end
