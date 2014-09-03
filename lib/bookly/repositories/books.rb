module Bookly
  module Repositories
    class Books

      def initialize(db_name)
        @db = PG.connect(host: 'localhost', dbname: db_name)
      end

      def create_tables
        @db.exec(%q[
          CREATE TABLE IF NOT EXISTS books(
            id serial NOT NULL PRIMARY KEY,
            name varchar(30),
            published_at date
          )])
      end

      def delete_all
        @db.exec("DELETE FROM books")
      end

      def all
        results = @db.exec("SELECT * FROM books")
        results.map {|row| build(row) }
      end

      def save(book)
        if book.id.nil?
          # The book has no id; that means we need to create it
          sql = %q{ INSERT INTO books (name, published_at) VALUES ($1, $2)
                    returning id; }
          results = @db.exec(sql, [book.name, book.published_at])
          row = results.first
          book.instance_variable_set("@id", row["id"])
        else
          # The book *does* have an id, so we need to update it
          sql = "UPDATE books SET (name, published_at) = ($1, $2)"
          @db.exec(sql, [book.name, book.published_at])
        end
      end

      def find(book_id)
        sql = "SELECT * FROM books WHERE id=$1"
        results = @db.exec(sql, [book_id])
        row = results.first

        book = build(row)
        book.instance_variable_set("@id", row["id"])
        book
      end

      private

      def build(row)
        Bookly::Book.new(row["name"], Date.parse(row["published_at"]))
      end
    end
  end
end
