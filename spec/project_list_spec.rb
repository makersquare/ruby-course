require 'spec_helper'

describe 'ProjectList' do
  before do
    @project_list = TM::ProjectList.new
    # @project = TM::Project.new('new_project')
  end

  describe '#add_project' do
    it 'adds a project' do

      @project_list.add_project('take out the trash')

      result = @project_list.projects

      expect(result[0].project_name).to eq('take out the trash')
    end
  end

  # describe '#list_projects' do
  #   it 'lists all projects' do
  #     @project_list.add_project('take over the world')
  #     @project_list.add_project('write a better javascript engine')
  #     @project_list.add_project('sleep')

  #     expect(STDOUT).to receive(:puts).with('take over the world')
  #     expect(STDOUT).to receive(:puts).with('write a better javascript engine')
  #     expect(STDOUT).to receive(:puts).with('sleep')

  #     @project_list.list_projects


  #   end
  # end
  describe '#add_task_to_project' do
    it 'adds a task to a project' do
      @project_list.add_project('house chores')

      description = 'take out the trash'
      priority = 1
      pid = 2
      # new_task = Task.new(description, priority, pid)

      # project = @project_list.projects.find{|project| project.project_name == 'house chores'}

      # project.add_task(new_task)
      # binding.pry

      @project_list.add_task_to_project(description, priority, pid)

      result = @project_list.projects[0].tasks

      expect(result[0].description).to eq('take out the trash')
      expect(result[0].priority).to eq(1)
      expect(result[0].project_id).to eq(2)

    end
  end

  describe '#show_remaining_tasks' do
    it 'Shows remaining tasks for project with id=PID' do

      project_name = 'house chores'
      @project_list.add_project(project_name)

      pid = 3

      @project_list.add_task_to_project('take out trash', 2, pid)
      @project_list.add_task_to_project('vacuum', 1, pid)
      @project_list.add_task_to_project('mop', 3, pid)

      selected_project = @project_list.projects.find{|project| project.id == pid}

      # result = selected_project.tasks.select {|task| task.complete == false}

      result = @project_list.show_remaining_tasks(pid)

      expect(result).to eq (selected_project.tasks)

    end
  end

end
