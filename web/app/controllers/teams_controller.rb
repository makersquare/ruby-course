
class TeamsController < ApplicationController
  def index
    result = Timeline::GetTeams.run
    if result.success?
      @teams = result.teams
      render 
    else
      @teams = []
      render alert: "Error accessing teams."
    end    
  end

  def show
    @team_id = params[:team_id].to_i
    @team_name = params[:team_name]
    result = Timeline::GetTeamEvents.run :team_id => @team_id
    if result.success?
      @events = result.events
      render    
    else
      return redirect_to({:action => :index}, alert: "Error accessing team events.") unless @events
    end
  end
end
