module Timeline
	class CreateEvent < UseCase
		def run(inputs)
			team_id = inputs[:team_id].to_i
			user_id = inputs[:user_id].to_i
			name = inputs[:name]

			return failure(:team_id_not_found) if Timeline.db.get_team(team_id) == nil
			return failure(:no_event_name) if inputs[:name] == nil
			return failure(:no_team_id) if inputs[:team_id] == nil

			event = Timeline.db.create_event(inputs)

			success :event => event
		end
	end
end