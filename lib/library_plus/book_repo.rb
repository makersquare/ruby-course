module Library
  class BookRepo
    def self.all(db)
      db.exec("SELECT * FROM books").to_a
    end
    def self.find(db, book_id)
      db.exec("SELECT * FROM books WHERE id = $1", [book_id]).first
    end
    def self.save(db, book_data)
      if book_data['id']
        sql = %q[
          UPDATE books SET title = $1 WHERE id = $2 RETURNING *
        ]
        db.exec_params(sql,[book_data['title'],book_data['id']]).first
      else
        sql = %q[
          INSERT INTO books (title,author) 
            VALUES ($1, $2) RETURNING * 
          ]
        db.exec_params(sql,[book_data['title'],book_data['author']]).first
      end
    end
    def self.destroy(db, book_id)
        sql = %q[
            DELETE FROM books WHERE id = $1
        ]
        db.exec_params(sql, book_id['book_id'])
    end
    def self.check_out(db, check_out)
        sql= %q[
          INSERT INTO checkouts (book_id, user)
                VALUES ($1,$2) RETURNING *;
          UPDATE books SET checked_out = true WHERE id = $1 
              ]
        db.exec_params(sql, [check_out['book_id'],check_out['user']]).first
    end
    def self.check_in(db, book_id)
        sql = %q[
          UPDATE books SET checked_out = false WHERE id = $1 
        ]
        db.exec_params(sql, [book_id['id']])
    end
  end
end