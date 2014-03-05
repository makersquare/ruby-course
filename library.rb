
class Borrower
  attr_reader :name
  attr_accessor :books_borrowed
  def initialize(name)
    @name = name
    @books_borrowed = []
  end
end

class Book
  attr_reader :author, :title, :year_published, :edition
  attr_accessor :checked_out, :status, :id, :borrower, :rating, :review

  def initialize(title, author, year_published=nil, edition=nil)
    @author = author
    @title = title
    @status = "available"
    @id = nil
    @borrower = nil
    @ratings = []
    @reviews = []
  end
def check_out(borrower)
 if @status == "available"
  @status = "checked_out"
  @borrower = borrower
  true
else
  false
end
end
def check_in
  if @status == "checked_out"
    @status = "available"
    @borrower = nil

  else
    false
end
def leave_rating(rating, review=nil)
  @ratings.push(rating)
  @reviews.push(review)
end
end
class Library
  attr_reader :name
  attr_accessor :books, :available_books, :borrowed_books
  def initialize(name)
    @books = []
    @name = name
    @available_books = []
    @borrowed_books = []
  end

  def register_new_book(title, author)
title = Book.new(title, author)
@books.push(title)
title.id = @books.count - 1
  end


  def add_book(title, author)
  end

  def check_out_book(book_id, borrower)
      final_book = nil
      cued_book = books[book_id]
      if cued_book.status == "available"
        if borrower.books_borrowed.count <=1
      cued_book.status = "checked_out"
      cued_book.borrower = borrower
       final_book = cued_book
      borrower.books_borrowed.push(cued_book.title)
    end
     end
     final_book
  end
  def get_borrower(book_id)
    books[book_id].borrower.name
  end

  def check_in_book(book)
    if book.status = "checked_out"
      book.status = "available"
      book.borrower = nil
    end
  end

  def available_books
    @books.select { |x| x.status == "available" }
  end

  def borrowed_books
    @books.select {|x| x.status == "checked_out"}
  end

end
