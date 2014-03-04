
class Book
  attr_reader :author, :id, :title, :status

  def initialize(title, author)
    @author = author
    @title = title
    #@id = nil
    @status = "available"
  end

  def check_out
    if (@status == "available")
      @status = "checked_out"
      return true
    else
      return false
    end
  end

  def check_in
    @status = "available"
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
