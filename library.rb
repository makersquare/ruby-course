
class Book

  attr_reader :author, :title
  attr_accessor :status, :id

  def initialize(title, author, id=nil)
    @author = author
    @title = title
    @status = "available"
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

  @@counter_id = 0

  attr_accessor :books, :name, :id

  def initialize(name)
    @books = []

  end

  def register_new_book(book)
    @books << book
    @@counter_id += 1
    book.id = @@counter_id

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
