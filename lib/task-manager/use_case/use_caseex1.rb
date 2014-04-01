use_caseex1.rb


module TM
  # name of class you create to inherent from UseCase
  class ProjectShow < UseCase

  def run(inputs)
    #inputs = {:pid => "user inputted pid"}
    project = TM.db.get_projects(inputs[:pid])

    return failure(:project_does_not_exists) if project.nil?

    success(:project => project)
  end
end


