require 'pry-byebug'

class Book
  attr_reader :title, :author
  attr_accessor :status, :id

  def initialize(title, author, id=nil)
    @title = title
    @author = author
    @id = id
    @status = 'available'
  end

  def check_out
    if @status == 'available'
      @status = 'checked_out'
      return true
    else 
      return false
    end
  end

  def check_in
    @status = 'available'
  end
end
  
class Borrower
  attr_reader :name

  def initialize(name)
    @name = name
  end
end

class Library
  attr_reader :name
  attr_accessor :books, :id_num, :books_out

  def initialize(name)
    @name = name
    @books_out = Hash.new(0)
    @books = [ ]
    @id_num = 0
  end

  def register_new_book(title, author)
    @books << Book.new(title, author, (@id_num += 1))
  end

  def check_out_book(book_id, borrower)
    checkedoutbook = nil
    people_with_books_out = @books_out.values
    people_books_out_count = Hash.new(0)
    people_with_books_out.each do |name|
      people_books_out_count[name] += 1
    end

    if people_books_out_count[borrower] < 1
      @books.each do |b|
        if b.id == book_id && b.status == 'available'
          b.check_out
          @books_out[book_id] = borrower
          checkedoutbook = b
        end
      end
    end
    checkedoutbook
  end

  def check_in_book(book)
    @books_out[book.id] = nil
    book.check_in
  end

  def get_borrower(book_id)
    @books_out[book_id].name
  end

  def available_books
    available_books = [ ]
    @books.each do |book|
      if book.status == "available"
        available_books.push(book)
      end
    end
    available_books
  end

  def borrowed_books
    borrowed_books = [ ]
    @books.each do |book|
      if book.status == "checked_out"
        borrowed_books.push(book)
      end
    end
    borrowed_books
  end
end