require 'csv'

class Book
  attr_reader :author, :title, :id, :status, :borrower, :reviews, :year, :edition

  def initialize(title="", author="",id=nil,year=nil,edition=nil)
    @title = title
    @author = author
    @status = "available"
    @id = id
    @reviews = {}
    @year = year
    @edition = edition
  end

  def review(borrower,rating,review="")
    @reviews["#{borrower.name}"] = {rating: rating, review:review}
  end

  def check_out(borrower=nil)
    if @status == "available"
      @status="checked_out"
      @borrower = borrower
      return true
    else
      false
    end
  end

  def check_in()
    if @status == "checked_out"
      @status="available"
      @borrower=nil
      return true
    else
      false
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

  def initialize(name="")
    @books = []
  end

  def register_new_book(name, author, year=nil, edition=nil)
    @books.push(Book.new(name, author, @books.count, year, edition))
  end

  def import_books(file)
    CSV.foreach(File.path("#{file}")) do |col|
      register_new_book(col[0],col[1])
    end
  end

  def check_out_book(book_id, borrower)
    @books.each do |book|
      if book.borrower == borrower
        return nil
      end
    end
      if @books[book_id].check_out(borrower)
        return @books[book_id]
      else
        nil
     end
  end

  def get_borrower(book_id)
    @books[book_id].borrower.name
  end

  def check_in_book(book)
    book.check_in()
  end

  def available_books
    @books.select { |book| book.status == "available"}
  end

  def borrowed_books
    @books.select { |book| book.status == "checked_out"}
  end
end
