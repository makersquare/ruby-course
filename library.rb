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
  attr_accessor :name, :has_overdue_books

  def initialize(name)
    @name = name
    @has_overdue_books = false
  end

  def leave_review(book,rating,review)
    book.ratings << rating
    book.reviews << review
  end
end

class Library
  attr_reader :books, :borrowers, :available_books, :checked_out_books, :queued_books

  def initialize(name)
    @books = []
    @borrowers = {}
    @available_books = []
    @checked_out_books = []
    @queued_books = []
    @queued_borrowers = {}
  end

  def register_new_book(book)
    book.id = rand()
    @books << book
  end

  def check_out_book(book, borrower)
    check_out_count = 0
    # Count how many times a borrower's name appears in the borrowers hash. If more than 2, no more books can be borrowed
    @borrowers.each do |key,value|
      if value == borrower
        check_out_count += 1
      end
    end

    # If less than 2 books have been checked out by the borrower and the book is available, book can be checked out
    if check_out_count < 2
      if (book.status == 'available') && (borrower.has_overdue_books == false)
        book.status = 'checked_out'
        @borrowers[book] = borrower
        book.due_date = Time.now + (86400*7)
        checked_out_books << book
        return book
      elsif (book.status == 'checked_out') && (borrower.has_overdue_books == false)
        @queued_books << book
        @queued_borrowers[book] = borrower
        return 0
      end
    end
  end

  def get_borrower(book)
    borrower = @borrowers[book]
    borrower.name
  end

  def check_in_book(book)
    # Remove book from borrowers hash and change book status to available
    @borrowers.delete(book)
    @checked_out_books.delete(book)
    book.status = 'available'
    book.overdue = false

    # If a book is queued for checkout when it is checked in, it should be checked out to the queued borrower
    if @queued_borrowers[book]
      check_out_book(book,@queued_borrowers[book])
    end

  end

  def available_books
    # Iterate through @books hash and return all books with available status
    @books.select {|book| book.status == 'available'}
  end

  def borrowed_books
    # Iterate through @books hash and return all books with checked_out status
    @books.select {|book| book.status == 'checked_out'}
  end

  def overdue_books(book, now=Time.now)
    now = now
    if book.due_date < now
      book.overdue = true
    end

    # Find the borrower of the overdue book and set mark them as having overdue books
    od_borrower = @borrowers.select{|book| book}
    od_borrower[book].has_overdue_books = true
  end

  def list_checked_out_books
    @checked_out_books.each do |book|
      puts "#{book.title.capitalize} is due back on #{book.due_date}"
    end
  end

  # CSV extension
  def import_from_csv(filename)
    book_import = CSV.read(filename)
    book_import.each do |book|
      @books << Book.new(book[0],book[1])
    end
  end

end
