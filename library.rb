
class Book
  attr_reader :author, :title
  attr_accessor :id, :status

  def initialize(title, author, id=nil)
    @title = title
    @author = author
    @id = id
    @status = "available"
  end

  def check_out
    if @status == "available"
      @status = "checked_out" 
      true
    elsif @status == "checked_out"
      return false
    end
  end

  def check_in
    @status = "available" if @status = "checked_out"
  end
end

class Borrower
  attr_reader :name

  def initialize(name)
    @name = name
  end
end

class Library
  attr_reader :name, :books

  def initialize(name)
    @name = name
    @books = []
  end

  def register_new_book(title, author, id)
  end

  # def books
  # end

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
