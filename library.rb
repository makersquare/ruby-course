class Book
  attr_accessor :author, :title, :id, :status

  def initialize(title, author, id=nil)
    @title = title
    @author = author
    @id = id
    @status = "available"
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
    @status = "available"
  end
end

class Borrower
  attr_reader :name
  attr_accessor :counter
  def initialize(name)
    @name = name
    @borrowed_books = []
    @counter = 0
  end

  def borrow_book(book)
    @borrowed_books.push(book)
  end
end

class Library
  attr_accessor :books, :borrowers_books
  def initialize(name)
    @books = []
    @available_borrowed_count = Hash.new(0)
    @borrowers_books = {}
  end

  def books=(book)
    @books.push(book)
  end

  def add_book(title, author)
    @books.push(Book.new(title, author, rand(20000).to_s)) #should have used
    #a counter instead of rand and used a counter as a class variable
    #so no one book has the same ID regardless of where it's located. 
  end

  def check_out_book(book_id, borrower)
    found_book = nil
    @books.each do |book| 
      if book.id == book_id  && book.status != "checked_out" && borrower.counter < 2 #ravi and ben
        #helped me with the counter solution and ben helped me change it from 3 to 2 - crappy logic on my part.
        book.status = "checked_out"
        borrower.borrow_book(book)
        @borrowers_books[book.id] = borrower.name #jimmy helped some with this
        found_book = book
        borrower.counter+=1
      end
    end
  found_book
end

  def check_in_book(book)
    book.status = "available"

  end

  def get_borrower(book_id)
    @borrowers_books[book_id] #Professor Nick helped me with this.
  end


  def available_books
    @books.select{|book| if book.status == "available" then book end}
  end

  def borrowed_books
    borrowed_books_array = []
    @books.map do |book| 
      if book.status == "checked_out"
        borrowed_books_array.push(book)
      end
    end
    borrowed_books_array
    #doesn't work either - 
  end
end
