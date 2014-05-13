require 'pry'

class TM::Employee

  attr_reader :name, :id

  def initialize(params)
    @name = params[:name]
    @id = params[:id]
  end

  # def assign_project(pid)
  #   if TM.db.projects[pid]
  #     TM.db.update_membership(pid: pid, eid: @id, add: true)
  #   else
  #     return false
  #   end
  # end

  # def remove_project(pid)
  #   if TM.db.projects[pid]
  #     TM.db.update_membership(pid: pid, eid: @id)
  #   else
  #     false
  #   end
  # end


end
