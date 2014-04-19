require 'timeline'

module Timeline
	class CreateEvent < UseCase
		def run(inputs)
			team_id = inputs[:team_id]
			name = inputs[:name]
			description = inputs[:description]

			return failure(:team_id_not_found) if Team.find(team_id) == nil
			return failure(:no_event_name) if inputs[:name] == nil
			return failure(:no_team_id) if inputs[:team] == nil

			event = Database::PersistentDB::Event.create(attrs)

			success :event => invite
		end
	end
end