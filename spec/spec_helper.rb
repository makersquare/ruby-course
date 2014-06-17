# Require our project, which in turns requires everything else
require './lib/task-manager.rb'

def reset_class_variables(cl)
  cl.class_variables.each do |var|
    cl.class_variable_set(var, nil)
  end
end
