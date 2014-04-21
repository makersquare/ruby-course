class TeamsController < ApplicationController
  def index
    result = Timeline::GetTeams.run

    if (result.success?)
      @teams = result.teams
    end

    render 'teams/index'
  end
  def show
    @team_id = params[:id]

    result = Timeline::GetTeamEvents.run(team_id: @team_id)
    if (result.success?)
      @events = result.events
    else
      if (result.error == :team_doesnt_exist)
        @error = "team doesn't exist!"
      end
    end

    render = 'teams/show'
  end
  def results
    team_id = params[:team_id]
    result = Timeline::GetTeamEvents.run(team_id: team_id)

    if (result.success?)
      @events = result.events
    else
      if (result.error == :team_doesnt_exist)
        @error = result.error
      end
    end

    render = 'teams/results'
  end
end
