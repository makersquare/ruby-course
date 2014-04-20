class EventsController < ApplicationController
  def create
    puts "#{params}"
    result = Timeline::CreateEvent.run(params)
    if (result.success?)
      @event = result.event
      puts "#{@event.name}"
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
