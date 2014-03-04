
class Book
  attr_reader :author, :title, :status
  attr_accessor :id

  def initialize(title, author)
    @title = title
    @author = author
    @status = "available"
    @id = nil
  end

  def check_out
    if @status == "available"
      @status = 'checked_out'
      true
    else
      false
    end
  end

  def check_in
    if @status == "checked_out"
    @status = "available"
  end
  end
end
#  END OF BOOK CLASS DEFINITION


class Borrower
  attr_reader :name
  def initialize(name)
    @name = name
  end
end

class Library

  def initialize(name)
    @name = name
    @books = []
  end

  def books
    @books
  end

  def register_new_book(title, author)
    new_book = Book.new(title, author)
    new_book.id = rand(1..100)
    add_book(title, author)
    @books << new_book
  end

  def add_book(title, author)
  end

  def check_out_book(book_id, borrower)

    @books.each do |book|
      if book.id == book_id
      book.check_out
      return book
      end
    end

  end

  def check_in_book(book)
  end

  def available_books
  end

  def borrowed_books
  end
end
