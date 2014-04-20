class TeamsController <ApplicationController
  def index
    @teams = Timeline::GetTeams.run({}).teams
  end

  def show
    @team = Timeline::GetTeamEvents.run(:team_id => params[:id].to_i).events
    @events = Timeline::GetTeamEvents.run(:team_id => params[:id].to_i).team
    # @message = flash[:notice]
  end
end
