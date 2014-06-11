require 'spec_helper'

describe 'Client' do

  it "exists" do
    expect(TM::Client).to be_a(Class)
  end

  describe "Available Commands" do
    it "'help' shows available commands"

    it "'list' lists all projects"

    it "'create' accepts NAME and creates a new project"

    it "'show' accepts PID and displays remaining tasks for that project"

    it "'history' accepts PID and displays completed tasks for that project"

    it "'add' accepts PID PRIORITY DESC and adds a new task to the project"

    it "'mark' accepts TID and marks that Task as complete"
  end
end
