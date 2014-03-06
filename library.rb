class Book
  attr_reader :author, :title
  attr_accessor :status, :id, :borrower

  def initialize(title, author)
    @author = author
    @title = title
    @status = "available"
    @id = id
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
attr_accessor :books, :title, :records, :available_books, :borrowed_books
  def initialize(name)
    @books = []
    @records = {}

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
        if book.status == "checked_out" || borrower.checked_out.any? == true
          return nil
        else
          @records.store(book_id, borrower)     #updates registry
          book.status = "checked_out"           #updates book
          @books[book_id].borrower = borrower   #updates book's borrower
          borrower.checked_out << book_id       #updates borrower's checked_out
          return book
        end
      end
    end
  end

  def get_borrower(book_id)
    @records[book_id].name
  end

  def check_in_book(book)
    book.status = "available"

  end

  def available_books
    @books.select do |book|
      if book.status == "available"
        book
      end
    end
  end

  def borrowed_books
    @books.select do |book|
      if book.status == "checked_out"
        book
      end
    end
  end
end
