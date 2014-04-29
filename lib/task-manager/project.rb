
class TM::Project
  attr_reader :id, :name

  def initialize(name)
    @name = name
    @id = self.class.generate_id
    @created_at = Time.now
    self.class.add_project(self)
  end

  def self.add_project(project)
    @@projects ||= {}
    @@projects[project.id] = project
  end

  def self.projects
    @@projects ||= {}
  end

  def complete_tasks
    complete = TM::Task.tasks.select do |k, v|
      (v.project_id == self.id) && v.complete?
    end

    complete.values.sort_by { |task| task.created_at }
  end

  def incomplete_tasks
    incomplete = TM::Task.tasks.select do |k, v|
      (v.project_id == self.id) && !v.complete?
    end

    incomplete.values.sort_by { |task| [task.priority_number, task.created_at] }
  end

  private

  def self.generate_id
    tmp = @@id_counter ||= 0
    @@id_counter +=1
    tmp
  end
end
