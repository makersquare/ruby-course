class TM::DB
attr_accessor :projects, :tasks, :employees, :memberships

def initialize
  @projects = {}
  @tasks = {}
  @employees = {}
  @memberships = {}
end

end
