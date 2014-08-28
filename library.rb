
class Book
  attr_reader :author, :title, :status
  attr_accessor :id

  def initialize(title="", author="")
    @title = title
    @author = author
    @id = nil
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

  def check_out_book(book_id, borrower)
    checking_out = @books.select {|book| book.id == book_id}.first
    checking_out.check_out
    checking_out
  end

  def check_in_book(book)
  end

  def available_books
  end

  def borrowed_books
  end
end