
class Book

  attr_reader :author, :title, :id, :status

  def initialize(title, author, id=nil)
    @author = author
    @title = title
    @id = id
    @status = 'available'
  end

  def check_out
    if @status == 'checked_out'
       return false
    else
      @status = 'checked_out'
      true
    end
  end

  def check_in
    @status = 'available'
  end
end



class Borrower

  attr_reader :name

  def initialize(name)
    @name = name
    @last_id = 0
  end
end

class Library

  def initialize
    @books = []
  end

  def books
    @books
  end

  def register_new_book(title, author)
    last_id =+ 1
    @books << Book.new(title, author, id=0)

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
