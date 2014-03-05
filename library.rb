
class Book
  attr_accessor :author, :title, :id, :status

  def initialize(title, author, status="available")
    @title = title
    @author = author
    @id = nil
    @status = status
  end

  def check_out
    if @status == "available"
    @status = "checked_out"
    true
  else 
    false
  end
  end

  def check_in
    @status = "available"
  end


end

class Borrower
  attr_accessor :name
  def initialize(name)
    @name = name
  end
end

class Library
  attr_accessor :title, :author, :id
  def initialize()
    @books = []
    @names =[]
  end

  def register_new_book(title, author, id)
    new_book = Book.new(title, author)
    new_book.id = id
    @books << new_book


  end

  def books
    @books
  end

  def add_book(title, author)
  end

  def check_out_book(book_id, borrower)
   chosen = @books.detect{|x| x.id == book_id}
   if chosen.status == "available"
   chosen.check_out
   @names.push(borrower, book_id)
   if @names.select{|x| x == borrower}.length < 2
   chosen
 else 
  return nil
end
end
     end


     def get_borrower(book_id)
     index = @names.find_index{|x| x == book_id}
      @names[index-1].name

     end

  def check_in_book(book)
    
    found = @names.find_index(book.id)
    @names.delete(@names[found-1])
    @names.delete(book.id)
    book.status = "available"
    

  end

  def available_books
    @books.select{|x| x.status == "available"}
  end

  def borrowed_books
      @books.select{|x| x.status != "available"}
      
  end
end
