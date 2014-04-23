require 'csv'

class Book
  attr_accessor :author, :title, :id, :status, :year_published, :edition, :ratings, :reviews, :due_date,
                :overdue

  def initialize(title, author, options = { })
    options = {year_published: nil, edition: nil}.merge(options)
    @author = author
    @title = title
    @status = "available"
    @year_published = options[:year_published]
    @edition = options[:edition]
    # Is ID necessary? We are referencing books by title instead of by id.
    @id = nil
    @ratings = []
    @reviews = []
    @due_date
    @overdue = false
  end

  def check_out
    if @status == 'checked_out'
      false
    else
      @status = 'checked_out'
    end
  end

  def check_in
    if @status == 'checked_out'
      @status = 'available'
    end
  end
end

class Borrower
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def leave_review(book,rating,review)
    book.ratings << rating
    book.reviews << review
  end
end

class Library
  attr_reader :books, :borrowers, :available_books

  def initialize(name)
    @books = []
    @borrowers = {}
    @available_books = []
  end

  def register_new_book(book)
    book.id = rand()
    @books << book
  end

  def check_out_book(book, borrower)
    check_out_count = 0
    # Count how many times a borrower's name appears in the borrowers hash. If more than 2, no more books can be borrowed
    @borrowers.each do |key,value|
      if value == borrower.name
        check_out_count += 1
      end
    end

    # If less than 2 books have been checked out by the borrower and the book is available, book can be checked out
    if check_out_count < 2
      if book.status == 'available'
        book.status = 'checked_out'
        @borrowers[book.title] = borrower.name
        book.due_date = Time.now + (86400*7)
        return book
      end
    end
  end

  def get_borrower(book)
    @borrowers[book.title]
  end

  def check_in_book(book)
    # Remove book from borrowers hash and change book status to available
    @borrowers.delete(book.title)
    book.status = 'available'
    book.overdue = false
  end

  def available_books
    # Iterate through @books hash and return all books with available status
    @books.select {|book| book.status == 'available'}
  end

  def borrowed_books
    # Iterate through @books hash and return all books with checked_out status
    @books.select {|book| book.status == 'checked_out'}
  end

  def overdue_books
    # Build array of books that are past their due date and iterate through each to mark them as overdue
    overdue_books = @books.select { |book| book.due_date < Time.now }
    overdue_books.each do |book|
      book.overdue = true
    end
  end

  def import_from_csv(filename)
    book_import = CSV.read(filename)
    book_import.each do |book|
      @books << Book.new(book[0],book[1])
    end
  end

end
