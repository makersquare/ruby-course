
class Book

  attr_reader :author, :title, :id, :status

  attr_accessor :checked_out_to

  def initialize(title, author, id=nil)
    @author = author
    @title = title
    @id = id
    @status = 'available'
  end

  def check_out
    if @status == 'checked_out'
       return false
    else
      @status = 'checked_out'
      true
    end
  end

  def check_in
    @status = 'available'
  end
end



class Borrower

  attr_reader :name

  attr_accessor :number_of_books

  def initialize(name)
    @name = name
    @has_book = true
  end
end




class Library

  def initialize
    @books = []
    @last_id = 0
    @borrowers_hash = {}
  end

  def books
    @books
  end

  def register_new_book(title, author)
    @last_id =+ 1
    @books << Book.new(title, author, id=@last_id)

  end

  def check_out_book(book_id, borrower)
    books.each do |book|
      if book.id == book_id
        book.check_out 
        @borrowers_hash[book.id] = borrower
        return book
      end
    end
  end

  def get_borrower(book_id)
    @borrowers_hash[book_id].name
  end


  def check_in_book(book) 
  end

  def available_books
  end

  def borrowed_books
  end
end
