
class Book
  attr_reader :author
  attr_reader :title
  attr_accessor :id
  attr_accessor :status
  attr_accessor :borrower

  def initialize(title, author)
    @author = author
    @title = title
    @status = "available"
    @id = nil
    @borrower = nil
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
    @id_counter = 0
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
    @books.each do |book_instance|
        if  book_instance.id == book_id && book_instance.status == "available"
          book_instance.borrower = borrower
          book_instance.status = "checked_out"
          return book_instance
        end
    end
    nil   #only reach this code if book doesnt exist in library
  end

  def get_borrower(book_id)
     @books.each do |book|
       if book.id == book_id
         return book.borrower.name
       end
     end
     nil
  end

  def check_in_book(book)
  end

  def available_books
  end

  def borrowed_books
  end
end
