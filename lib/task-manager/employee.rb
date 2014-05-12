require 'pry'

class TM::Employee

  attr_reader :name, :id, :pid, :tid

  def initialize(params)
    @name = params[:name]
    @id = params[:id]
    @pid = params[:pid]
  end



end
