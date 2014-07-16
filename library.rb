
class Book
  attr_reader :author, :title, :id, :status

  def initialize(title, author)
    @author = author
    @title = title
    @id = self.object_id.abs
    @status = :available
  end

  def check_out
    if @status == :available
      @status = :checked_out
      true
    elsif @status == :checked_out
      false
    end
  end

  def check_in
    @status = :available
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
    @checkouts = {}
  end

  def register_new_book(title, author)
    new_book = Book.new(title, author)
    @books << new_book
  end

  def check_out_book(book_id, borrower)
    this_book = @books.find { |x| x.id == book_id }
    if @checkouts.select{ |k,v| v == borrower }.size >= 2
      return nil
    end
    if this_book.check_out
      @checkouts[book_id] = borrower
      this_book
    end
  end

  def get_borrower(book_id)
    @checkouts[book_id].name
  end

  def check_in_book(book)
    book.check_in
    @checkouts.delete_if { |key, value| key == book.id }
  end

  def available_books
    available_books = @books.delete_if{ |x| @checkouts.has_key?(x.id) }
    available_books
  end

  def borrowed_books
    borrowed_books = @books.select{ |x| @checkouts.has_key?(x.id) }
    borrowed_books
  end
end
