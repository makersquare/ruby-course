
class Book
  attr_reader :author, :title, :id, :status

  def initialize(title, author, id=nil, status="available")
    @author = author
    @title = title
    @id = id
    @status = status
  end

  def check_out
    if @status == "checked_out"
      return false
    else
      @status="checked_out"
      return true
    end
  end

  def check_in
    @status="available"
  end

end

class Borrower
  attr_reader :name

  def initialize(name)
    @name = name
  end
end

class Library
  attr_reader :name, :books, :book_id, :borrower_hash, :available_books, :borrowed_books
  attr_accessor :book_id_counter

  def initialize(name)
    @name = name
    @books = []
    @book_id_counter = 0
    @borrower_hash = {}
    @available_books = []
    @borrowed_books = []
  end

  # def books
  # end
  def register_new_book(title, author)
    @book_id_counter += 1
    book = Book.new(title, author, book_id_counter)
    @books << book
    @available_books << book
  end

  # def add_book(title, author)
  # end

  def check_out_book(book_id, borrower)
    selected_book = @books.select {|book| book.id == book_id}.pop
    return nil if selected_book.status == "checked_out"
    if @borrower_hash.select{|k,v| v == borrower}.count == 2
      return nil
    else
      selected_book.check_out
      @borrower_hash[book_id] = borrower
      @available_books.delete(selected_book)
      @borrowed_books << selected_book
    end
    return selected_book
  end

  def get_borrower(book_id)
    @borrower_hash[book_id].name
  end

  def check_in_book(book)
    book.check_in
  end

  def available_books
    @available_books
  end

  def borrowed_books
    @borrowed_books
  end
end
