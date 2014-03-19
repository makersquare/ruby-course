require 'spec_helper'

describe 'Project' do



  before do
    @newproject = TM::Project.new("MakerSquare", 1)
    @newtask = TM::Task.new(@projectid,"teach ruby", 3, 5)
    @secondtask = TM::Task.new(2,"teach ruby", 3, 5,)
    @thirdtask = TM::Task.new(2,"teach ruby", 3, 5,)
    @fourthtask = TM::Task.new(2,"teach ruby", 3, 5,)
    @projectid = @newproject.projectid
  end


  it "exists" do
    expect(TM::Project).to be_a(Class)
  end


  it "A new project can be created with a name assign the new project a unique id, also empty tasks" do
    expect(@newproject.projectid).to eq (1)
    expect(@newproject.tasklist.count).to eq 0
  end

  it "Add task to project" do


     addingtask = @newproject.add_task_to_project(@newtask)
     expect(addingtask.count).to eq 1
     addingtask_more = @newproject.add_task_to_project(@secondtask)
     expect(addingtask_more.count).to eq 2
  end


  it "A project can retreve a list of all complete task, via creation date" do
     Time.stub(:now).and_return(Time.parse("1pm"))
     # Time.stub(:now).and_return (normalhour)
     addingtask = @newproject.add_task_to_project(@newtask)
     Time.stub(:now).and_return(Time.parse("5pm"))
     addingtask_more = @newproject.add_task_to_project(@secondtask)
     Time.stub(:now).and_return(Time.parse("9pm"))
     @newproject.add_task_to_project(@thirdtask)
     project_list_task = @newproject.tasklist

    project_list_task.sort {|x,y| y.creationtime <=> x.creationtime }
        project_list_task.each do |x|

          puts x.creationtime
        end
     # a.sort { |x,y| y <=> x }
  end

  xit "A project can retreive a list of all incomplete tasks, sorted by priority"  do

  end

end
