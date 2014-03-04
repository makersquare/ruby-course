
class Book
  attr_reader :author
  attr_accessor :title
  attr_accessor :status


  def initialize(title="", author="")
    @author = author
    @title = title
    @book_id = nil
    @status = "available"
  end

  def id
    @book_id
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
      return true
    else
      return false
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
  attr_accessor :books

  def initialize
    @books = []
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
