module Timeline
  class GetTeam < UseCase
    def run(inputs=nil)
      # name1 = inputs[:name1]
      # name2 = inputs[:name2]
      # name3 = inputs[:name3]
      return failure(:no_teams_exists) if Timeline.db.all_teams == []
      teams = Timeline.db.all_teams
      success(:team => teams)
    end
  end
end


# module Timeline
#   class GetTeams < UseCase
#     def run(inputs=nil)
#       teams = Timeline.db.all_teams
#       success(teams: teams)
#     end
#   end
# end


# module Timeline
#   class GetTeamEvents < UseCase
#     def run(inputs)
#       team_id = inputs[:team_id]
#       return failure(:no_team_with_that_id) if Timeline.db.get_team(team_id) == nil
#       return failure(:team_has_no_events) if Timeline.db.get_events_by_team(team_id) == []
#       events = Timeline.db.get_events_by_team(team_id)
#       success(:event=>events)
#     end
#   end
# end
