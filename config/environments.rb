
if ENV['APP_ENV'] == 'development'
  Honkr.db = Honkr::Databases::SQL.new
else
  Honkr.db = Honkr::Databases::InMemory.new
end

# TODO: ESTABLISH ACTIVE RECORD CONNECTION
