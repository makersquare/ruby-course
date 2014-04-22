
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
      num_books_borrowed = @borrowers.inject(0) {|sum, x| x == borrower ? sum +=1 : sum }
      if num_books_borrowed > 1 
        return nil
      else
        @borrowers[book_id -1] = borrower
        book_to_checkout.check_out
        return book_to_checkout
      end
    end
  end


  def get_borrower(book_id)
    return @borrowers[book_id-1].name
  end


  def check_in_book(book)
    @books[book.id-1].check_in
    @borrowers[book.id-1] = nil
  end

  def available_books
    @books.select {|x| x.status == "available"}
    # no check if 0 books available, probably returns NilClass
    # books_available = books.select {|x| x.status == "available"}
    # if books_available == nil
    #   return 0
    # else
    #   return books_available
    # end
  end

  def borrowed_books
    books_borrowed = @books.select {|x| x.status == "checked_out"}
    # books_available = books.select {|x| x.status == "checked_out"}
    # if books_available == nil
    #   return 0
    # else
    #   return books_available
    # end
  end
end
