class TM::Project
  attr_reader :id, :name

  def initialize(name)
    @name = name
    @id = self.class.generate_id
    @created_at = Time.now
    self.class.add_project(self)
  end


  def self.add_project(project)
    @@projects ||= []
    @@projects << project
    self.projects
  end

  def self.projects
    @@projects ||= []
  end

  def complete_tasks
    complete = TM::Task.tasks.select do |t|
      (t.project_id == self.id) && t.complete?
    end

    complete.sort_by { |t| t.created_at }
  end

  def incomplete_tasks
    incomplete = TM::Task.tasks.select do |t|
      (t.project_id == self.id) && !t.complete?
    end

    incomplete.sort_by { |t| [t.priority_number, t.created_at] }
  end

  private

  def self.generate_id
    tmp = @@id_counter ||= 0
    @@id_counter +=1
    tmp
  end
end
