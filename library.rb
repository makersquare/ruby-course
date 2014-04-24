
class Book
  attr_reader :author, :status, :title
  attr_accessor :id, :check_out, :status

  def initialize(title, author)
    @title = title
    @author = author
    @status = "available"
    @id = nil
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
    @status = "available"
  end
end

class Borrower
  attr_reader :name

  def initialize(name)
    @name = name
  end
end

class Library
  attr_reader :borrower
  attr_accessor :books

  def initialize(name)
    @books = []
    @id_count = 1
  end

  def register_new_book(book)
    @books << book
    book.id = @id_count
    @id_count += 1
  end

  def add_book(title, author)
  end

  def check_out_book(book_id, borrower)
    book = @books.select { |book| book.id == book_id }.first
    book.check_out
    book
  end

  def get_borrower(book_id)
    @borrower = check_out_book.name
  end

  def check_in_book(book)
    if book.status == "checked_out"
      book.check_in
    end
  end

  def available_books
    @books.select { |book| book.status == "available"}
  end

  def borrowed_books
    @books.select { |book| book.status == "checked_out"}
  end
end
