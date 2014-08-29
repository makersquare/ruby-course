
class Book
  attr_reader :author, :title 
  attr_accessor :status, :id 

  def initialize(title, author, id=nil)
    @title = title
    @author = author
    @id = id
    @status = "available"
  end

  def check_out
    if @status == "available"
       @status = "checked_out"
    else
        false
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
  attr_accessor :books, :borrower, :idnum, :borrowed_books
  def initialize(name)
    @books = []
    @idnum = 0
    @borrower = {}
  end

  def books
    @books
  end

  def register_new_book(title, author)
    @books << Book.new(title, author, (@idnum += 1))
  end


  def check_out_book(book_id, borrower)
   bcount = @borrower.select {|k,v| v == borrower}
   if bcount.length > 1
    return nil
  else
    @books.each do |b|
      if b.id == book_id && b.status == "available"
        b.check_out
        @borrower[book_id] = borrower
        return b 
      end
    end
      return nil
    end
  end

  def get_borrower(book_id)
    @borrower[book_id].name
  end

  def check_in_book(book)
    book.check_in
    @borrower[book] = "available"
  end

  def available_books
    available_books = []
    @books.each do |b|
      if b.status == "available"
        available_books.push(b)
      end
    end
    available_books
  end

  def borrowed_books 
  borrowed_books = []
    @books.each do |b|
      if b.status != "available" 
        borrowed_books.push(b)
      end
    end
    borrowed_books
  end
end
