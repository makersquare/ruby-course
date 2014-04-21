class EventsController < ApplicationController
  def create
    name = params[:name]
    user_id = params[:user_id].to_i
    team_id = params[:team_id].to_i
    result = Timeline::CreateEvent.run(name: name, user_id: user_id, team_id: team_id)

    if (result.success?)
      flash[:msg] = "user created!"
      # redirect_to ("/teams/#{params[:team_id]}")
    else
      if (result.error == :user_doesnt_exist)
        flash[:msg] = "user does not exist!"
        # redirect_to ("/teams/#{params[:team_id]}")
      end
    end
    redirect_to ("/teams/#{params[:team_id]}")
  end
end
