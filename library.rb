
class Book
  attr_reader :author
  attr_reader :title
  attr_accessor :id
  attr_reader :status
  attr_accessor :borrower

  def initialize(title, author)
    @title = title
    @author = author
    @status = "available"
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
  attr_reader :books
  attr_reader :count
  @@counter = 0

  def initialize
    @books = []
    @count = @books.length
  end

  # def count
  #   return @books.length
  # end

  # def books
  #   return @books
  # end

  def register_new_book(book)
    @books << book
    book.id = @@counter
    @@counter += 1
  end

  def check_out_book(book_id, borrower)
    @books.each do |book|
      if book.id == book_id
        if book.check_out == false
          return nil
        else
          book.borrower = borrower.name
          return book
        end
      else
        return "No book with that id is in this library"
      end
    end
  end

  def get_borrower(book_id)
    @books.each do |book|
      if book.id == book_id
        return book.borrower
      end
    end
  end

  def check_in_book(book)
    book.check_in
  end

  def available_books
  end

  def borrowed_books
  end
end
