module Timeline
	class GetTeams < UseCase
		def run(inputs=nil)
			
			return failure(:no_teams) if Timeline.db.all_teams == nil
	
			all_teams = Timeline.db.all_teams

			success :teams => all_teams
		end
	end
end