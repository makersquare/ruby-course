
class Book
  attr_reader :author, :title, :id, :status
  def initialize(title="", author="")
    @title = title
    @author = author
    @id = nil
    @status = "available"

  def title=(title)
    @title=title
  end

  def author=(author)
    author=author
  end

  def status=(status)
    @status=status
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
