
class Book
  attr_reader :author
  attr_reader :title
  attr_reader :id
  attr_reader :status
  def initialize(title, author)
    @title = title
    @author = author
    @id = nil
    @status = 'available'
  end

  def check_out
    if @status == 'available'
      @status = 'checked_out'
    else
      puts "u can't"
    end
  end

  def check_in
    @status = 'available'
  end
end

class Borrower
  def initialize(name)
    @pname = name
    @books = []
  end
end

class Library
  def initialize(name)
    @lname = name
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
