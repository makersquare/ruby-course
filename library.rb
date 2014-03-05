
class Book
  attr_reader :title, :author, :id
  attr_accessor :status

  def initialize(title, author)
    @title = title
    @author = author
    @status = "available"
  end

  def check_out
    if @status == "checked_out"
      return false
    else
    @status = "checked_out"
    end
    return true
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
