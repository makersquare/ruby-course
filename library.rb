class Book
  attr_reader :author, :title
  attr_accessor :status, :id

  def initialize(title, author)
    @author = author
    @title = title
    @status = "available"
    @id = id
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
    if @status == "checked_out"
      @status = "available"
      true
    else
      false
    end
  end

end

class Borrower
attr_accessor :name, :checked_out
  def initialize(name)
    @name = name
    @checked_out = []
  end

end

class Library
attr_accessor :books, :title
  def initialize(name)
    @books = []
    @library = {}
  end

  def books
    @books
  end

  def register_new_book(title, author)
    new_book = Book.new(title, author)
    @books.push(new_book)
    new_book.id = @books.length - 1
  end

  def add_book(title, author)
  end

  def check_out_book(book_id, borrower)
    @books.each do |book|
      if book.id == book_id
        if book.status == "checked_out"
          return "checkout out"
        else
          book.status = "checked_out"
          return book
        end
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
