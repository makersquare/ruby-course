
class Book
  attr_accessor :author, :title, :id, :status

  def initialize(title, author, status: 'available')
    @title = title
    @author = author
    @status = status
    @id = nil
  end

  def check_out()
    if status == 'available'
      @status = 'checked_out'
      true
    else
      false
    end
  end

  def check_in()
    if status == 'checked_out'
      @status = 'available'
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

  def initialize(name)
    @books = []
  end

  def count
    @books.size
  end

  # replaced w. attr_accessor
  # def books
  # end

  def add_book(title, author)
    new_book = Book.new(title, author)
    new_book.id = 1 + rand(100000000)
    books << new_book

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
