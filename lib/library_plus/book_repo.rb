module Library
  class BookRepo

    def self.all(db)
      # Other code should not have to deal with the PG:Result.
      # Therefore, convert the results into a plain array.
      b = db.exec("SELECT * FROM books").to_a
      checkouts = Library::CheckoutRepo.all_by_book(db)
      b.each do |book|
        book['available'] = true
        id = book['id']
        if (checkouts[id])
          book['checkouts'] = checkouts[id]
          book['checkouts'].each do |checkout|
            book['available'] = false if !checkout['return_date']
          end
        end
      end
      return b
    end

    def self.find(db, book_data)
      book = db.exec("SELECT * FROM books WHERE id = #{book_data}").to_a[0]
      checkouts = Library::CheckoutRepo.find_with_user(db, 'book_id' => book['id']) # should return array
      book['available'] = true

      if (checkouts)
        book['checkouts'] = checkouts
        book['checkouts'].each do |checkout|
          book['available'] = false if !checkout['return_date']
        end
      end
      
      return book
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
