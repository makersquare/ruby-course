
class Book
  attr_accessor :id, :status, :title, :author

  def initialize(title='default_title', author='default_author')
    @author = author
    @title = title
    @status = "available"
  end

  def check_out
    if @status == "available"
      @status = "checked_out"
      true
    else
      false
    end
  end

  def check_in
    @status = "available"
  end
end

class Borrower
  def initialize(name)
    @name = name
  end

  def name
    @name
  end
end

class Library

  @@book_id_counter = 0

  def initialize(name='default_library_name', books=[])
    @name = name
    @books = books
  end

  def books
    @books
  end

  def register_new_book(title, author)
    new_book = Book.new(title, author)
    @books << new_book
    @@book_id_counter += 1
    new_book.id = @@book_id_counter
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
