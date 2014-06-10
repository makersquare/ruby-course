require 'spec_helper'

describe 'Task' do
  it "exists" do
    expect(TM::Task).to be_a(Class)
  end

  describe '#initialize' do
    it "is a Task"
    it "inherits the project id" #class variable?
    it "has a description"
    it "has a priority number"
    it "has a default complete status of 'false'"
    it "has a creation date"
  end

  describe '#change_complete_status'
    it "marks the task as incomplete if it's complete"
    # it "marks the task as complete if it's incomplete"
end
