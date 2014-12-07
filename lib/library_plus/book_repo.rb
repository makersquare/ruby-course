module Library

  class BookRepo 
    
    def self.all(db)
      db.exec('SELECT * FROM books;').to_a
    end
    
  end

end