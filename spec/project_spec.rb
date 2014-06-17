require 'spec_helper'
require 'rspec'
require 'pry-debugger'

describe 'Project' do
  context 'project' do
    it "exists" do
      expect(TM::Project).to be_a(Class)
    end
  end
  context 'tasks' do
    it 'adds instances of task class' do
      proj1 = TM::Project.new(1)
      proj1.create_task('groceries', 3)
      expect(proj1.tasks.first.desc).to eq('groceries')
      expect(proj1.tasks.first.key).to eq(3)
    end
    it 'returns sorted array of completed events' do
      proj1 = TM::Project.new('mks')
      future_completed = []
      future_completed << proj1.create_task('walk', 10)
      future_completed << proj1.create_task('workout', 3)
      proj1.create_task('code', 7)
      future_completed << proj1.create_task('family', 5)
      proj1.mark_complete(0)
      proj1.mark_complete(1)
      proj1.mark_complete(3)
      results = proj1.sort_complete
      # completed_events = []
      # results.each do |task|
      #   completed_events << task.desc
      # end
      # expect(completed_events).to eq(future_completed)
    end
    it 'returns sorted array of uncompleted taks by priority' do
      proj1 = TM::Project.new('mks')
      proj1.create_task('walk', 10)
      proj1.create_task('workout', 3)
      proj1.create_task('code', 7)
      proj1.create_task('family', 9)
      proj1.mark_complete(2)
      results = proj1.sort_priority # better naming
      important_events = []
      results.each do |task|
        important_events << task.desc
      end
      #least to greatest
      expect(important_events).to eq(['workout', 'family', 'walk'])
    end
  end
end
