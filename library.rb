
class Book
  attr_reader :author, :title, :status, :borrower
  attr_accessor :id

  def initialize(title="", author="")
    @title = title
    @author = author
    @id = nil
    @status = "available"
    @borrower = nil
  end

  def check_out(borrower=nil)
    if @status == "available"
      @status = "checked_out"
      @borrower = borrower
      return true
    else 
      return false
    end
  end

  def check_in
    @status = "available"
    @borrower = nil
  end
end

class Borrower
  attr_reader :name
  def initialize(name)
    @name = name
  end
end


class Library
  attr_accessor :books

  def initialize(name="")
    @name = name
    @books = []
    @id_giver = 0
  end

  def register_new_book(title, author)
    temp = Book.new(title,author)
    @id_giver += 1
    temp.id = @id_giver
    @books << temp
  end

  def add_book(book)
    @id_giver += 1
    book.id = @id_giver
    @books << book
    book
  end

  def check_out_book(book_id, borrower)
    checking_out = @books.select {|book| book.id == book_id}.first
    if checking_out.check_out(borrower)
      checking_out
    else 
      nil
    end
  end

  def get_borrower(book_id)
    book_out = @books.select {|book| book.id == book_id}.first
    book_out.borrower.name
  end

  def check_in_book(book)
    book.check_in
  end

  def available_books
  end

  def borrowed_books
  end
end