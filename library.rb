require 'pry-byebug'

class Book
  attr_reader :title, :author, :id, :status

  def initialize(title, author, id=nil, status="available")
    @title = title
    @author = author
    @id = id
    @status = status
  end

  def check_out
    if @status == "checked_out"
      return false
    end
    @status = "checked_out"
    true
  end

    def check_in
    if @status == "available"
      return false
    end
    @status = "available"
    true
  end

end

class Borrower
  attr_reader :name, :books
  def initialize(name)
    @name = name
  end
end

class Library
  attr_reader :name, :books, :available_books, :borrowed_books
  def initialize(name)
    @name = name
    @books = []
    @id_count = 1
    @borrowers = {}
    @available_books = []
    @borrowed_books = []
  end

  def add_book(title, author)
    book = Book.new(title, author, @id_count)
    @books << book
    @available_books << book
    @id_count += 1
  end

  def check_out_book(book_id, borrower)
    # binding.pry
    if @borrowers.has_key?(borrower.name)
      return nil if @borrowers[borrower.name].size > 1
    end

    checked_book = @books.find { |book| book.id == book_id}
    return nil unless checked_book.check_out

    if @borrowers.has_key?(borrower.name)
      @borrowers[borrower.name] << checked_book.id
    else
      @borrowers[borrower.name] = [checked_book.id]
    end
    @available_books.delete(checked_book)
    @borrowed_books.push(checked_book)
    checked_book
  end

  def check_in_book(book_id, borrower)        
    checked_book = @books.find {|book| book.id == book_id}
    return nil unless checked_book.check_in

    if @borrowers.has_key?(borrower.name)
      @borrowers[borrower.name].pop(checked_book.id)
    else
      return nil
    end
    @available_books.push(checked_book)
    @borrowed_books.delete(checked_book)
    checked_book
  end

  def get_borrower(book_id)
    @borrowers.each do |borrower, books|
      books.each do |book_num|
        if book_num == book_id
          return borrower
        else
          nil #If nil is returned, then nobody borrowed that book.
        end
      end
    end
  end
end
