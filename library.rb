
class Book
  attr_reader :author
  attr_reader :title
  attr_accessor :id
  attr_reader :status

  def initialize(title, author)
    @author = author
    @title = title
    @status = "available"
    @id = nil
  end

  # def check_out
  #   @status = "checked_out"
  # end

   def check_out # made a condital to see what happen run twice 4th test
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

  attr_reader :books
  attr_reader :id
  def initialize(name)
    @books = []
    @id_counter = 1
  end

  def count
    @books.length
  end

  def register_new_book(title, author)
    b = Book.new(title, author)
    @books << b
    b.id = @id_counter
    @id_counter += 1
  end

def check_out_book(book_id, borrower)
       @borrowers = {}
       @books.each do |book|
           if book.id == book_id
            @borrowers[book_id] = borrower
            book.check_out
            return book
           end
       end
   end


  def check_out_book(book_id, borrower)
  end

  def check_in_book(book)
  end

  def available_books
  end

  def borrowed_books
  end
end
