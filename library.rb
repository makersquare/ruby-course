
class Book
  attr_reader :author, :title, :id,:status
  def initialize(title="default_title", author ="default_author", id = nil)
    @author = author
    @title = title
    @id = id
    @status = "available"
  end

  def check_out
    if @status == "checked_out"
      return false 
    else
      @status = "checked_out"
      return true
    end
  end

    def check_in
    if @status == "checked_out"
      @status = "available"
      return true 
    else
      @status = "checked_out"
      return false
    end
  end

  # def a?(test)
  #   true
  # end

end

class Borrower
  attr_reader :name

  def initialize(name)
    @name = name
  end

end

class Library
  # attr_reader :books
  def initialize(name="Library of Alexandria")
    @name = name
    @books = []
    @borrowers = []
  end

  def books
    return @books
  end

  def register_new_book=(new_book)
    register_new_book(new_book.title, new_book.author)
  end

  def register_new_book(title, author)
    book = Book.new(title, author, @books.count+1)
    @books << book
  end

  def add_book(title, author)
  end

  def check_out_book(book_id, borrower)
    book_to_checkout = @books[book_id -1]
    if book_to_checkout.status == "checked_out"
      return nil
    else
      @borrowers[book_id -1] = borrower
      book_to_checkout.check_out
      return book_to_checkout
    end
  end


  def get_borrower(book_id)
    return @borrowers[book_id-1].name
  end


  def check_in_book(book)
  end

  def available_books
  end

  def borrowed_books
  end
end
