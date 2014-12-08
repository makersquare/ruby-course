module Library
  class BookRepo

    def self.all(db)
      db.exec("SELECT * FROM books").to_a
    end

    def self.checked_out?(db, book_id)
sql = %q[
      SELECT status,
      created_at 
      from checkouts 
      where book_id = $1
      GROUP BY status, created_at
      ORDER BY created_at DESC
      limit 1
    ]
      book = db.exec(sql,[book_id]).entries.first
      if book  == nil || book['status'] == 'returned'
        status = false 
      else 
        status = true
      end 
      status
    end
      
    def self.checkin (db, book_id)
      db.exec("update checkouts SET status = $1 where book_id = $2  returning *",["returned", book_id])[0] 
    end 
    
    def self.check_out(db, user_id, book_id, status)
      if status
        return nil
      else 
     sql = %q[   
        INSERT into checkouts (
          user_id, book_id, status) 
          values ($1, $2, $3) returning *
]
      book = db.exec(sql,[user_id, book_id, 'checked_out'])[0]
      end 
      book 
    end

    def self.find(db, book_id)
       db.exec("select * from books where id = $1",[book_id])[0]
    end

    def self.find_all_checkeout_user(db, book_id)
       db.exec("select user_id from checkouts where book_id = $1", [book_id]).entries
    end   

    def self.find_all_checkeout_books(db, user_id)
       db.exec("select book_id from checkouts where user_id = $1", [user_id]).entries
    end 

    def self.save(db, book_data)
        if book_data['id'] 
          if book_data['title'] && book_data['author']
            db.exec("UPDATE books SET title = $1, author = $2 WHERE id = $3 returning *",[book_data['title'], book_data['author'], book_data['id']])[0]      
          elsif book_data['title']
            db.exec("UPDATE books SET title = $1 WHERE id = $2 returning *",[book_data['title'], book_data['id']])[0]      
          else   
            db.exec("UPDATE books SET author = $1 WHERE id = $2 returning *",[book_data['author'], book_data['id']])[0]      
          end  
        else
          db.exec("INSERT into books (title, author) values ($1, $2) returning *", [book_data['title'], book_data['author']])[0]
        end
    end

    def self.destroy(db, book_id)
       db.exec("DELETE FROM books WHERE id = $1", [book_id])
    end

  end
end

