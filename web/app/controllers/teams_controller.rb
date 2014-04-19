class TeamsController < ApplicationController
  def show
    puts params
    @team = Timeline.db.get_team(params[:id].to_i)
    # @message = params[:notice]
    @team_name = @team.name
    @team_events = Timeline::GetTeamEvents.run(team_id: @team.id.to_i).events
    puts @team_events
    puts @team_events.size
  end

  def index
    @teams = Timeline::GetTeams.run({}).teams
  end
end
