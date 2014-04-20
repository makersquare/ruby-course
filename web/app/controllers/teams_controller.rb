class TeamsController < ApplicationController
  def index
    @teams = Timeline::GetTeams.run({}).teams

  end

  def show
    @events = Timeline::GetTeamEvents.run(:team_id => params[:id].to_i).events
    @team = Timeline::GetTeamEvents.run(:team_id => params[:id].to_i).team
    @message = flash[:notice]
  end
end
