require "pry-byebug"
class Book
  attr_reader :author, :title, :id
  attr_accessor :status, :borrower

  def initialize(title, author, id=nil)
    @author = author
    @title = title
    @id = id
    @status="available"
    @borrower = ""
  end

  def status
    @status
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
    if @status == "checked_out"
      @status = "available"
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
  attr_accessor :books, :books_avai

  def initialize(name="Someone's Library")
    @books = []
    @books_avai = []
  end

  def register_new_book(book_object)
    @books.push(book_object)
  end

  def add_book(title, author)
  end

  def check_out_book(book_id, borrower)
    books.find do |book_object|
      if book_object.id == book_id && book_object.status == 'checked_out'
        return nil
      elsif book_object.borrower == borrower
        return nil
      else 
        book_object.title
        book_object.status = 'checked_out'
        book_object.borrower = borrower
            # binding.p€ry
      end
    end
  end

  def check_in_book(book)
    book.status = 'available'
  end

  def get_borrower(book_id)
    books.find do |book_object|
      if book_id == book_object.id
        return book_object.borrower.name
      end
    end
  end

  def available_books
    @books.select { |book_object| book_object.status == "available" }
    # @books.each do |book_object|
    #   if book_object.status == "available"
    #     @books_avai.push(book_object)
    #   else 
    #     @books_avai.delete(book_object)
    #   end
    # end
    # @books_avai
  end

  def borrowed_books
    @books.select { |book_object| book_object.status == "checked_out" }
  end
end
