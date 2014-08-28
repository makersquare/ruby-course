
class Book
  attr_accessor :status
  attr_reader :author, :title, :id

  def initialize(title=nil, author=nil, id=nil)
    @title = title
    @author = author
    @id = id
    @status = 'available'
  end

  def status
    @status
  end

  def check_out
    if @status == "available"
      @status = "checked_out"
      true
    else
      false
    end
  end
end

class Borrower
  def initialize(name)
  end
end

class Library
  def initialize(name)
    @books = []
  end

  def books
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
