require 'spec_helper'

describe 'Task' do
	describe "initialize method" do
		it "exists" do
			expect(TM::Task).to be_a(Class)
		end

		it "can be initialized with a name" do
			task1 = TM::Task.new("task1")
			expect(task1.name).to eq("task1")
		end

		it "adds to global class variable @@tasks[]" do

		end

		it "has a default name of 'default' if name not specified" do
			task1 = TM::Task.new
			expect(task1.name).to eq("default")

		end

		it "creates a unique ID is created starting with id=1" do
			task1 = TM::Task.new
			expect(task1.id).to eq(3)
		end

		it "has a project ID that defults to nil (unassigned)" do

		end

		it "creates multiple unique IDS in numerical order" do
			task1 = TM::Task.new
			task2 = TM::Task.new
			task3 = TM::Task.new
			expect(task1.id).to eq(4)
			expect(task2.id).to eq(5)
			expect(task3.id).to eq(6)
		end

		it "can be initialized with a description" do

		end

		it "has default description of 'none'" do

		end

		it "has a priority number" do

		end

		it "has a default priority number of 1" do

		end

		it "has a creation date" do

		end

		it "creation date works with Time.now" do

		end

		it "has a completed boolean variable with default value false" do

		end

		it "has a completed date with default value nil" do 
		end


	end

	describe "list_all_tasks method" do
		# not sure how to implement!! defer until later

		xit "lists the correct number of tasks ever created" do 
			#test by creating three tasks and checking @@tasks
		end

	end

	describe "mark_completed method" do

		it "can set @completed to true" do 
			
		end

		it "can set @completed to false" do 
			
		end

	end

end
