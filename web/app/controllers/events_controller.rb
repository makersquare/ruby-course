class EventsController < ApplicationController
  def create
    result = Timeline::CreateEvent.run(:name => params[:name], :user_id => params[:user_id].to_i, :team_id => params[:team_id].to_i)
    @team_id = params[:team_id].to_i
    if result.success?
      redirect_to "/teams/#{@team_id}"
    end
  end
end




# def show
#     @team_id = params[:team_id].to_i

#     result = Timeline::GetTeamEvents.run(:team_id => @team_id)
#       if result.success?
#         @events = result.events
#       end
#       render 'teams/events'
#   end
