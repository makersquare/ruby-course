module Library
  class BookRepo

    def self.all(db)
      # Other code should not have to deal with the PG:Result.
      # Therefore, convert the results into a plain array.
      db.exec("SELECT * FROM books").to_a
    end

    def self.find(db, book_data)
      db.exec("SELECT * FROM books WHERE id = #{book_data}").to_a[0]
    end

    def self.save(db, book_data)
      if book_data["id"]
        s = ""
        if(book_data["title"])
          s+="title = '"+book_data["title"]+"'"
        end
        if(book_data["title"] && book_data["author"])
          s+=","
        end
        if(book_data["author"])
          s+="author = '"+book_data["author"]+"'"
        end
          db.exec("UPDATE books SET #{s} WHERE id = #{book_data['id']} returning *").to_a[0]
      else
        db.exec("INSERT INTO books (title, author) VALUES ('#{book_data["title"]}', '#{book_data["author"]}') returning *").to_a[0]
      end 
    end

    def self.destroy(db, book_data)
        r = db.exec("DELETE FROM books WHERE  id = #{book_data}")
        return r.cmd_status()
      end
  end
end
# TODO
