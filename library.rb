
class Book
  attr_reader :author, :title, :id

  def initialize(title, author, id=nil)
    @author = author
    @title = title
  end
  
  def status 
    return 'available'
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
