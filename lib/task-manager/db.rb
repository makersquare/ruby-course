
class TM::DB

  def initialize
    @projects = {
      # 1 => {
      # :id => 1,
      # :name => "My Project"
    # }
    }
    @project_count = 0
  end

  def build_project(data)
    # Create a new instance of a project with name as data
  end

  def update_project(id, data)
    # Find a project by id in the @project hash and update
    # Data is a hash of k,v pairs with :name => "name", etc
  end

  def destroy_project(id)
    # Find a project by id in the @project hash and remove
  end

  def show_project(id)
    # Find project by id in @project hash
  end

  def create_project(data)
    # Insert project into database, call in build method
  end

end
