
class Book
  attr_reader :author
  attr_reader :title
  attr_accessor :id
  attr_accessor :status
  attr_accessor :borrower
  attr_accessor :borrowed_books
  def initialize(title, author)
    @author = author
    @title = title
    @status = "available"
    @id = nil
    @borrower = nil
    @borrowed_books = []
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
  attr_accessor :havebook
  attr_reader :name
  def initialize(name)
    @name = name
    @havebook = [] # list of data think an array , had havebook = 0 before
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
        if borrower.havebook.count < 2
          borrower.havebook << book_id
        book_instance.borrower = borrower # don't know why this works
        book_instance.status = "checked_out"
        book_instance.borrower.havebook.count
        return book_instance
        end
        end
    end
    nil   #only reach this code if book doesnt exist in library
  end

  def get_borrower(book_id)
    @books.each do |book|
      if book.id == book_id
        return book.borrower.name    #
      end
    end
    nil
  end

  def check_in_book(book) #not correct just chaniign,#delete from @books
    @books.each do |book_instance|
      if book_instance == book
        book_instance.status = "available"
      end
    end
  end

  def available_books
    @books.select do|book_instance|
      book_instance.status == "available"
    end
  end

  def borrowed_books
    @books.select do |book_instance|
      book_instance.status == "checked_out"
    end
  end

end
