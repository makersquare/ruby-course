class Book
  attr_reader :author, :title
  attr_accessor :id, :status, :borrower

  def initialize(title, author)
    @author = author
    @title = title
    @id = nil
    @status = "available"
    @borrower = nil
  end

  def check_out
    if @status == "checked_out"
      false
    else
      @status = "checked_out"
      true
    end
  end

  def check_in
    @status = "available"
  end
end


class Borrower
  attr_reader :name, :borrowed

  def initialize(name)
    @name = name
    @borrowed = []
  end
end

class Library
  attr_accessor :books, :name, :title, :author, :id

  def initialize(name="")
    @name = name
    @id_count = 0
    @books = []
  end

  def add_book(title, author)
  end

  def register_new_book(book)
    @books.push(book)
    book.id = @id_count
    @id_count = @id_count + 1
  end


  def check_out_book(book_id, borrower)
  book =@books.select {|b| b.id = book_id}.first
  book.check_out
  book
  end


  def get_borrower(book_id)
    book = @books.select {|bk| bk.title == book_id}
    book.first.borrower.name
  end

  def check_in_book(book)
    if book && book.status =="checked_out"
    book.status = "available"
  end
  end


  def available_books
  available_books = []
  @books.map do |bk|
    if bk.status == "available"
    available_books << bk
  end
  end
    available_books
  end


  def borrowed_books
    books_out = []
    @books.map do |bk|
      if bk.status == "checked_out"
      books_out << bk
    end
  end
    books_out
end
end

