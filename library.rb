
class Book
  attr_reader :author, :title
  attr_accessor :status, :id, :last_borrower

  def initialize(title, author, id=nil, status='available', last_borrower=nil)
    @title = title
    @author = author
    @id = id
    @status = status
    @last_borrower = last_borrower
  end

  def check_out
    if @status == 'available'
      @status = 'checked_out'
      true
    else
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
  attr_reader :name, :current_books

  def initialize(name, current_books=[])
    @name = name
    @current_books = []
  end
end

class Library
  attr_accessor :books, :name, :book_id, :borrowed_books

  def initialize(name)
    @books = []
    @book_id = 0
    @borrowed_books = []
    #ID help from K izzle
  end

  def books
    @books
  end

  def register_new_book(book_object)
    book_object.id = @book_id +=1
    @books << book_object
  end

  def add_book(title, author)
    Book.new(title, author)
  end

  def check_out_book(book_id, borrower)
    book = @books.find {|x| x.id == book_id}
    if book.last_borrower == borrower
      return nil
    elsif book.status == "checked_out"
      return nil      
    else
      if borrower.current_books.length >= 2
        nil
      else 
        book.check_out
        book.last_borrower = borrower
        borrower.current_books << book
        @borrowed_books << book
        return book
      end
    end
  end

  def check_in_book(book)
    book.check_in
    @borrowed_books.delete(book)
  end

  def available_books
    available_books = @books.select {|x| x.status == "available"}
    available_books
  end

  def borrowed_books
    @borrowed_books
  end

  def get_borrower(book_id)
     book = @books.find {|x| x.id == book_id}
     return book.last_borrower.name
  end

end


