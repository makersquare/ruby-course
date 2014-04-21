class TeamsController < ApplicationController
  def index
    # you are going to run your use cases!

    result = Timeline::GetTeams.run()

    @teams = result.teams
  end

  def show
    # @team = Timeline.db.get_team(params[:team_id])
    # @team_events = Timeline.db.get_events_by_team(params[:team_id])
    # result = Timeline::GetTeamEvents.run(params[:team_id])
    #binding.pry

    @result = Timeline::GetTeamEvents.run({:id => params[:id]})

    @team_id = @result.team.id
    if @result.success?
      @teams = @result.team
      @events = @result.events
    else
      flash[:notice] = @result.error
      @error = result.error
      redirect_to =  '/teams'
    end

  end
end




# module Timeline
#   class GetTeamEvents < UseCase
#     def run(inputs)
#       # binding.pry
#       inputs[:team_id] = inputs[:team_id].to_i

#       team = Timeline.db.get_team(inputs[:team_id])
#       return failure(:missing_team) if team.nil?

#       events = Timeline.db.get_events_by_team(inputs[:team_id])
#       success(team: team, events: events)
#     end
#   end
# end



