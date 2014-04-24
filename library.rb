
class Book
  attr_accessor :author, :title, :status, :id

  def initialize(title, author)
    @author = author
    @title = title
    @status = "available"
    @id = nil
  end

  def check_out
    if @status == "available"
      @status = "checked_out"
    else
      return false
    end
    true
  end

  def check_in
    if @status == "checked_out"
      @status = "available"
    end
  end

end

class Borrower
  attr_accessor :name

  def initialize(name)
    @name = name
  end
end

class Library
  attr_accessor :count, :title, :author

  def initialize
    @count = []
  end

  def books
    @count
  end

  def register_new_book(title, author)
    title = Book.name
    author = Book.author
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
