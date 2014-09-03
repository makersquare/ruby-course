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

      def save(book)
        if book.id.nil?
          # The book has no id; that means we need to create it
          sql = %q{ INSERT INTO books (name, published_at) VALUES ($1, $2)
                    returning id; }
          result = @db.exec(sql, [book.name, book.published_at])
          book.instance_variable_set("@id", result[0]["id"])
        else
          # The book *does* have an id, so we need to update it
          sql = "UPDATE books SET (name, published_at) = ($1, $2)"
          @db.exec(sql, [book.name, book.published_at])
        end
      end

      def find(book_id)
        sql = "SELECT * FROM books WHERE id=$1"
        result = @db.exec(sql, [book_id]).first

        book = Bookly::Book.new(result["name"], Date.parse(result["published_at"]))
        book.instance_variable_set("@id", result["id"])
        book
      end
    end
  end
end
