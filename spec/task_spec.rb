require 'spec_helper'

describe 'Task' do
	describe "initialize method" do
		it "can be initialized with a name" do
			task1 = TM::Task.new("task1")
			expect(task1.name).to eq("task1")
		end

		it "has a default name of 'default' if name not specified" do
			task1 = TM::Task.new
			expect(task1.name).to eq("default")

		end

		it "creates a unique ID is created starting with id=1" do
			task1 = TM::Task.new
			expect(task1.id).to eq(3)
		end

		it "creates multiple unique IDS in numerical order" do
			task1 = TM::Task.new
			task2 = TM::Task.new
			task3 = TM::Task.new
			expect(task1.id).to eq(4)
			expect(task2.id).to eq(5)
			expect(task3.id).to eq(6)
		end

		it "has a project ID that defults to nil (unassigned)" do
			task1 = TM::Task.new
			expect(task1.project_id).to eq(nil)
		end

		it "can be initialized with a description" do
			task1 = TM::Task.new("test", description: "hello")
			expect(task1.description).to eq("hello")
		end

		it "has default description of 'none'" do
			task1 = TM::Task.new
			expect(task1.description).to eq("none")

		end

		it "has a default priority number of 1" do
			task1 = TM::Task.new
			expect(task1.priority).to eq(1)
		end

		it "has a @date_created" do
			# allow(Time).to receive(:now).and_return(Time.parse("1/1/2014"))
			task1 = TM::Task.new
			# expect(task1.).to eq(1)
			expect(task1.date_created.class).to eq(Time)
		end

		it "has a @completed boolean variable with default value false" do
			task1 = TM::Task.new
			expect(task1.completed).to eq(false)
		end

		it "has a @date_completed with default value nil" do 
			task1 = TM::Task.new
			expect(task1.date_completed).to eq(nil)
		end


	end

	describe "list_all_tasks method" do
		# not sure how to implement!! defer until later

		xit "lists the correct number of tasks ever created" do 
			#test by creating three tasks and checking @@tasks
		end

	end

	describe "mark_completed method" do

		xit "can set @completed to true" do 
			
		end

		xit "can set @completed to false" do 
			
		end

	end

end
