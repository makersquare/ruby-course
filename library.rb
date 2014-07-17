
class Book
  attr_reader :author, :title, :id, :status, :borrower

  def initialize(title, author, id= nil)
    @title = title
    @author = author
    @status = 'available'
    @id = id
    @borrower = nil
  end

  def check_out(borrower=nil)
    if @status == "checked_out"
      return false
    else
     @status = "checked_out"
     @borrower = borrower
     return true
    end
  end

  def check_in
    if @status == "available"
      return false
    else
      @status = 'available'
      @borrower = nil
      return true
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
  attr_reader :books, :borrowers
  def initialize
    @books = []
    @borrowers = {}
  end

  def register_new_book(title, author)
    @books << Book.new(title, author, @id = (books.count + 1))
  end

  def check_out_book(book_id, borrower)
    @books.each do |x|
      if x.id == book_id
        x.check_out
        return x
      end
    end
    @borrowers[book_id] = borrower
  end

  def get_borrower(book_id)
    @books.each do |x|
      if x.id == book_id
        return x.borrower.name
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
