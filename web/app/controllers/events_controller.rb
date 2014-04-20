class EventsController < ApplicationController
  def create
    name = params[:name]
    user_id = params[:user_id].to_i
    team_id = params[:team_id].to_i
    result = Timeline::CreateEvent.run(name: name, user_id: user_id, team_id: team_id)

    if (result.success?)
      @event = result.event
      redirect_to ("/teams/#{params[:team_id]}")
    else
      if (result.error == :no_user_id_provided)
        @error = "no user id provided!"
      elsif (result.error == :user_doesnt_exist)
        @error = "user does not exist!"
      elsif (result.error == :no_team_id_provided)
        @error = "no team id provided!"
      else
        @error = "team doesnt exist!"
      end
    end
  end
end
