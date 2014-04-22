
class Book
  attr_reader :author , :title
  attr_accessor :status, :id

  def initialize(title, author)
    @author = author
    @title = title
    @status = "available"
    @id= nil
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
  attr_reader :name

  def initialize(name)
    @name = name
  end
end

class Library
  attr_accessor :books
  @@count= 0
  def initialize(name)
    @books = []
    @name = name
    @@count=0
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
  end

  def add_book(title, author)
    @@count+=1
  end

  def check_out_book(book_id, borrower)
    b = @books.select {|x| x.title == book_id}
    b[0].check_out
    b[0]
  end

  def check_in_book(book)
  end

  def available_books
  end

  def borrowed_books
  end
end
