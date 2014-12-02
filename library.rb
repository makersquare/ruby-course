
class Book
  attr_reader :author, :title 
  attr_accessor :id, :status

  def initialize(title, author)
    @author = author
    @title = title
    @status = "available"
  end

  def check_out
    if @status == "available"
      @status = "checked_out"
      return true
    else 
      return false
    end
  end

  def check_in
    if @status == "checked_out"
      @status = "available"
    end
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
  attr_reader :name

  def initialize(name)
    @name = name
    @books = []
  end

  # def books
  # end
  def register_new_book(title, author)
    created_book = Book.new(title, author)
    @books << created_book
    created_book.id = self.books.count
  end
  def add_book(title, author)
  end

  def check_out_book(book_id, borrower)
  end

  def check_in_book(book)
  end

  def available_books
  end

  def borrowed_books
  end
end
