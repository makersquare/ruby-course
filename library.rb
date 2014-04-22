
class Book
  attr_reader :author , :title
  attr_accessor :status, :id, :borrower

  def initialize(title, author)
    @author = author
    @title = title
    @status = "available"
    @id= nil
    @borrower= nil
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
    if @status == "checked_out"
      @status = "available"
      return true
    else
      return false
    end
  end



end

class Borrower
  attr_reader :name, :borrowed

  def initialize(name)
    @name = name
    @borrowed=[]
  end
end

class Library
  attr_accessor :books, :books_in, :books_out
  @@count= 0
  def initialize(name)
    @books = []
    @name = name
    @@count=0
    @books_in=[]
    @books_out=[]
  end

  def books
    @books
  end

  def register_new_book(title, author)
    @@count+=1
    @@count
    a = Book.new(title, author)
    a.id = title
    @books<<a
    @books_in<<a
  end

  def add_book(title, author)
    @@count+=1
  end

  def check_out_book(book_id, borrower)
    b = @books.select {|x| x.title == book_id}
    if b[0].status == "checked_out"
      return nil
    else
      b[0].check_out
      b[0].borrower = borrower
      b[0].borrower.borrowed<<b[0]
      if b[0].borrower.borrowed.count>2
        return nil
      else
        @books_out<<b[0]
        @books_in.delete(b[0])
        b[0]
      end
    end
  end

  def get_borrower(book_id)
    b = @books.select {|x| x.title == book_id}
    b.first.borrower.name
  end

  def check_in_book(book)
    book.check_in
    @books_in<<book
    @books_out.delete(book)
  end

  def available_books
    @books_in
  end

  def borrowed_books
    @books_out
  end
end
