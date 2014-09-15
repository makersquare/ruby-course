module Songify
  module Tables
    def self.build_table
      PG.connect(host: "localhost", dbname: "songify").exec(%q[
        CREATE TABLE IF NOT EXISTS genres(
          id serial UNIQUE,
          genres text
        );

        CREATE TABLE IF NOT EXISTS songs(
          id serial,
          artist text,
          title text,
          album text,
          length int,
          genre_id int references genres(id)
        )
      ])
    end

    def self.drop_table
      PG.connect(host: "localhost", dbname: "songify").exec(%q[DROP TABLE songs])
      PG.connect(host: "localhost", dbname: "songify").exec(%q[DROP TABLE genres])
      build_table
    end
  end
end