
class Book
    attr_accessor :title, :author, :id, :status
  def initialize(title, author)
    @title = title
    @author = author
    @id = nil
    @status = "available"
  end

  def check_out
    if @status == "available"
        @status = "checked_out"
        true
      elsif @status == "checked_out"
        false
      end
    end

    def check_in
      if @status == "checked_out"
        @status = "available"
      else
        "That isn't our book!"
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
  attr_reader :books
  def initialize(name)
    @books = []
    @checkouts = {}
  end

  def register_new_book(title, author)
    new_book = Book.new(title, author)
    new_book.id = rand(1000) * Time.now.to_i
    @books << new_book
  end

    def check_out_book(book_id, borrower)
        check = @books.find{|x| x.id == book_id}
      if @checkouts.find_all{|k,v| v == borrower}.count >= 2
        return nil
      elsif check.check_out
        @checkouts[book_id] = borrower
        check
      end
    end    

  def get_borrower(book_id)
    @checkouts[book_id].name
  end

  def check_in_book(book)
    @checkouts.delete(book)
    book.check_in
  end

  def available_books
    @books.select {|x| x.status == "available"}
  end

  def borrowed_books
    @books.select {|book| book.status == "checked_out"}
  end
end
