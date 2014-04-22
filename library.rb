
class Book
  attr_reader :title
  attr_reader :author
  attr_accessor :id
  attr_reader :status

  def initialize(title, author)
    @title = title
    @author = author
    @id = id
    @status = 'available'
  end

  def check_out
    if @status == 'available'
      @status = 'checked_out'
      true
    elsif @status == 'checked_out'
      false
    end
  end

  def check_in
    if @status == 'checked_out'
      @status = 'available'
    end
  end
end

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
    @books_id = 0
    @borrowed_books = {}
  end

  def books
    @books
  end

  def register_new_book(book)
    book_id = @books.count
    @books_id += 1
    @books << book
    @books.last.id = book_id
  end

  def check_out_book(book_id, borrower)
    book = @books.select {|item| item.id == book_id}.first

    if book.status == 'available'
      book.check_out
      @borrowed_books[borrower] = book_id
      book
    end

  end

  def get_borrower(book_id)
    @borrowed_books.key(book_id).name
  end

  def check_in_book(book)
    if book.status == 'checked_out'
      book.check_in
    end
  end

  def available_books
  end

  def borrowed_books
    @borrowed_books
  end
end
