require 'spec_helper'

describe 'Task' do
	before (:each) do
		TM::Task.reset_class_variables
	end

	describe "initialize method" do
		it "can be initialized with a name" do
			task1 = TM::Task.new("task1")
			expect(task1.name).to eq("task1")
		end

		it "has a default name of 'default' if name not specified" do
			task1 = TM::Task.new
			expect(task1.name).to eq("untitled")
		end

		it "creates a unique ID" do 
			task1 = TM::Task.new
			task2 = TM::Task.new
			task3 = TM::Task.new
			expect(task1.id).to eq(1)
			expect(task2.id).to eq(2)
			expect(task3.id).to eq(3)
		end

		it "creates multiple unique IDS in numerical order" do
			task1 = TM::Task.new
			task2 = TM::Task.new
			task3 = TM::Task.new
			expect(task2.id-task1.id).to eq(1)
			expect(task3.id-task2.id).to eq(1)
		end

		# it "has a project ID that defults to nil (unassigned)" do
		# 	task1 = TM::Task.new
		# 	expect(task1.project_id).to eq(nil)
		# end

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

	describe "mark_completed method" do

		it "should set @completed to true and update @date_completed" do 
			task1 = TM::Task.new
			task1.mark_completed
			expect(task1.completed).to eq(true)
			expect(task1.date_completed.class).to eq(Time)
		end

		it "can set @completed to false" do 
			task1 = TM::Task.new
			task1.mark_completed
			expect(task1.completed).to eq(true)
			expect(task1.date_completed.class).to eq(Time)
		end

	end

	describe "mark_complete method" do
		it "should set @completed to false and update @date_completed" do 
			task1 = TM::Task.new
			task1.mark_completed
			expect(task1.completed).to eq(true)
			expect(task1.date_completed.class).to eq(Time)
		end
	end

	describe "mark_incomplete method" do
		it "should set @completed to false and update @date_completed" do 
			task1 = TM::Task.new
			task1.mark_incomplete
			expect(task1.completed).to eq(false)
			expect(task1.date_completed).to eq(nil)
		end
	end

end
