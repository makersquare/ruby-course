module Library
  class BookRepo
    def self.all(db)
      # Other code should not have to deal with the PG:Result.
      # Therefore, convert the results into a plain array.
      db.exec("SELECT * FROM books").to_a
    end

    def self.find(db, book_data)
      # find book by id
      sql = %Q[
        select *
        from books
        where id = $1
      ]
      result = db.exec(sql, [book_data])

      result.first
    end

    def self.save(db, book_data)
      # update book data if book exists, otherwise create new book
      if book_data.include?(:id)
        sql_users = %Q[
          UPDATE books
          set title =$1, author = $2
          where id = $3
          returning *
        ]
        result = db.exec(sql_users, [book_data[:title], book_data[:author], book_data[:id]])
      else
        sql_insert_user = %Q[
          insert into books 
          (title, author)
          values ($1, $2)
          returning *
        ]
        result = db.exec(sql_insert_user, [book_data[:title], book_data[:author]])
      end
      
      result.first
    end

    def self.check_out(db, check_out_data)
      check_out_data.each {|c| puts c}
      sql = %Q[
        insert into checkouts
        (book_id, user_id)
        values ($1, $2)
        returning *
      ]
      result = db.exec(sql, [check_out_data[:book_id], check_out_data[:user_id]])
    end

    def self.get_check_outs(db)
      sql = %Q[
        SELECT 
          books.title, 
          books.author, 
          books.id, 
          users.name
        FROM 
          books, 
          checkouts, 
          users
        WHERE 
          books.id = checkouts.book_id AND
          users.id = checkouts.user_id
      ]
      db.exec(sql).to_a
    end

    def self.destroy(db, book_data)
      sql = %Q[
        delete from books
      ]
      db.exec(sql)
    end
  end
end
