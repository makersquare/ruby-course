
class Book
  attr_reader :author, :title
  attr_accessor :id, :status, :borrower

  def initialize(title, author, id=nil, status="available")
    @author = author
    @title = title
    @id = id
    @status = status
    @borrower = "none"
  end

  def check_out
    if @status == "checked_out" 
      false 
    else 
      @status = "checked_out"
      true
    end
  end

  def check_in
    @status = "available"
  end
end

class Borrower
  attr_reader :name

  def initialize(name)
    @name = name
  end
end

class Library
  attr_accessor :books

  def initialize(name)
    @books = []
    @book_id = 1
  end

  def register_new_book(title, author)
    @books << Book.new(title, author, @book_id)
    @book_id +=1
  end

  def check_out_book(book_id, borrower)
    book = @books[book_id -1] 
    book.status = "checked_out"
    book.borrower = borrower
    book
  end

  def get_borrower(book_id)
    book = @books.find {|x| x.id == book_id}
    book.borrower.name
  end

  def check_in_book(book)
  end

  def available_books
  end

  def borrowed_books
  end
end
