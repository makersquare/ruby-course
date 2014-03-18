require 'spec_helper'

describe 'Project' do
	before do
		@project = TM::Project.new("SXSW")
	end

  it "exists" do
    expect(TM::Project).to be_a(Class)
  end

  describe ".initialize" do
	  it "should be initialized with a name" do
	  	expect(@project.name).to eq 'SXSW'
	  end

	  it "should be initialized with a unique id" do
	  	# The id here is 3 because two instances of Project were created before
	  	expect(@project.id).to eq(3)
	  end
	end

	describe "#add_task" do
		it "should add a task to the project" do
			add_task = @project.add_task('wash clothes', 4)
			expect(@project.tasks.count).to eq(1)
		end
	end
end
