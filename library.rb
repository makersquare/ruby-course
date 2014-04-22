
class Book
  attr_reader :author, :title
  attr_accessor :status

  def initialize(title, author)
    @author = author
    @title = title
    @status = "available"
  end

  def id
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

  def status
    return @status
  end


end

class Borrower
  attr_reader :name

  def initialize(name)
    @name = name
  end
end

class Library
  attr_accessor :books, :name

  def initialize(name)
    @books = []
  end

  def register_new_book(book)
    @books << book

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
