class Songify::Repo
  def initialize
    @db = PG.connect(dbname: 'songify-db')
  end
end