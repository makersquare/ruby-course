require 'pry'

class TM::Employee

  attr_reader :name, :id

  def initialize(params)
    @name = params[:name]
    @id = params[:id]
  end

  def assign_project(pid)
    TM.db.update_membership(pid: pid, eid: @id, add: true)
  end

  def remove_project(pid)
    TM.db.update_membership(pid: pid, eid: @id)
  end


end
