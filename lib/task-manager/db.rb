require 'Singleton'

class TM::DB

  include Singleton
  attr_reader :all_employees, :all_projects, :all_tasks, :participating

  def initialize
    @all_employees = {}
    @all_projects = {}
    @all_tasks = {}
    @participating = []
  end

end
