
class Book
  attr_reader :author, :title
  attr_accessor :status, :id
  def initialize(title, author, status="available")
    @title = title
    @author = author
    @status=status
    @id = nil

  end

   def check_out
    if @status=="available"
      @status = "checked_out"
      return true
    else

      return false
    end
end

  def check_in
    @status="available"
end
end

class Borrower
  attr_accessor :name
  def initialize(name)
    @name=name
  end
end

class Library
  attr_accessor :title, :author, :id, :names
  def initialize()
    @books = []
    @names = []
  end

  def books
    @books
  end

  def register_new_book(title,author,id)

    new_book = Book.new(title, author)
    @books.push(new_book)
    new_book.id = id
  end
  def add_book(title, author)
  end
  def check_out_book(book_id, borrower)
      checking= @books.detect{|x| book_id=x.id}
      if checking.status=="available"
        checking.check_out
        @names.push(borrower,book_id)
      if @names.select{|x| x==borrower}.length<2
      checking
    else
      return nil
  end
  end


end
  def get_borrower(book_id)
     index=@names.find_index{|x| x==book_id}
     @names[index-1].name
  end
  def check_in_book(book)
      book.status="available"

  end

  def available_books
    @books.select{|x| x.status=="available"}
  end

  def borrowed_books
    @books.select{|x| x.status=="checked_out"}
  end
end
