
class Book
  attr_accessor :status, :id, :title, :author
   @@i = 0
  def initialize(title, author)
    @author = author
    @title = title
    @id = nil
    @status = 'available'
  end

  def set_id
      @@i += 1
      @id = @@i
  end
  def check_out
      @status = "checked_out"
  end

  def check_in
    @status = "available"
  end
end

class Borrower
  attr_reader :name, :borrowed_books, :num
  
  def initialize(name)
    @name  = name
    @num = 0
    @borrowed_books = []
  end

  def borrow(book)
    if( @num < 2)
     # @borrowed_books << book
      @num +=1
    else
      puts "Cannot Borrow"
    end
  end

  def return(book)
    if( @num > 0)
      #@borrowed_books.delete(book)
      @num -=1
    else
      puts "No Books to return "
    end
  end
end

class Library
  attr_reader :books
  def initialize()
    @books = []
    @borrowed_books = {}
  end

  def register_new_book(title, author)
      temp = Book.new(title,author)
      temp.set_id
      @books << temp
  end
  
  def check_out_book(book_id, borrower)
      if(borrower.num < 2)
        @books.each do |book|
          if(book.id == book_id)
            if(book.status == "available")
              book.check_out
              borrower.borrow(book)
              @borrowed_books[book.id] = borrower
              return book
            end
          end  
        end  
      end
      return nil
  end

  def get_borrower(book_id)
      @borrowed_books.each  do |key, value|
        return value.name if(key == book_id)
      end
  end

  def check_in_book(book)
      person = @borrowed_books[book.id]
      book.check_in
      person.return(book)
      @borrowed_books.delete(book.id)

  end

  def available_books
      @books.find_all { |x| x.status == 'available'}
  end

  def borrowed_books
      @books.find_all { |x| x.status == 'checked_out'}
  end
end
