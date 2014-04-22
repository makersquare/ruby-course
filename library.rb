
class Book
  attr_accessor :id, :status, :title, :author, :borrower

  def initialize(title='default_title', author='default_author')
    @author = author
    @title = title
    @status = "available"
    @borrower = nil
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

  attr_accessor :backpack
  attr_reader :name

  def initialize(name)
    @name = name
    @backpack = []
  end
end


class Library
  @@book_id_counter = 0

  def initialize(name='default_library_name', books=[])
    @name = name
    @inventory = books
  end

  def books
    @inventory
  end

  def register_new_book(title, author)
    new_book = Book.new(title, author)
    @@book_id_counter += 1
    new_book.id = @@book_id_counter
    @inventory << new_book
  end

  def check_out_book(book_id, borrower)
    b = @inventory.select {|book| book.id == book_id}
    book = b.first
    book.check_out
    book.borrower = borrower
    book
  end

  def check_in_book(book)
  end

  def available_books
  end

  def borrowed_books
  end

  def get_borrower(book_id)
    book = @inventory.select {|book| book.id == book_id }
    book.first.borrower.name
  end
end
