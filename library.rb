
class Book
  attr_reader :title, :author, :id, :year_published, :edition
  attr_accessor :status, :borrowed_by, :reviews, :due_date

  def initialize(title, author, id=nil, year_published=nil, edition=nil)
    @title = title
    @author = author
    @id = id
    @status = 'available'
    @borrowed_by = nil
    @year_published = year_published
    @edition = edition
    @reviews = []
    @due_date = nil
  end

  def check_out
    if @status == 'available'
      @status = 'checked_out'
      @due_date = Time.now + 60*60*24*7
      return true
    else
      return false
    end
  end

  def check_in
    @status = 'available'
  end

  def borrowing_book(borrower)
    @borrowed_by = borrower
  end

  def is_book_late?
    if self.due_date > Time.now
      return true
    else
      return false
    end
  end

end

class Borrower
  attr_reader :name
  attr_accessor :book_borrowed, :books_reviewed, :books_borrowed, :late_books

  def initialize(name)
    @name = name
    @book_borrowed = nil
    @books_borrowed = []
    @books_reviewed = []
    @late_books = []
  end

  def book_that_was_borrowed(book)
    @book_borrowed = book
    @books_borrowed << book
  end

  def review_book(book, review, rating=nil)
    book.reviews << { :borrower => self.name,
                      :review => review,
                      :rating => rating
                    }
    self.books_reviewed << { :book => book,
                             :review => review,
                             :rating => rating
                           }
  end

  def any_late_books?
    self.books_borrowed.each do |book|
      if book.due_date < Time.now
        late_books << book
        return true
      end
    end
    false
  end

  def books_available(lib)
    lib.available_books.each do |book|
      puts "#{book.title}. Due Date: #{book.due_date}"
    end
  end

  def books_checked_out(lib)
    lib.borrowed_books.each do |book|
      puts "#{book.title}. Checked out by: #{book.borrowed_by}. Due Date: #{book.due_date}"
    end
  end

end

class Library
  attr_reader :name
  attr_accessor :books, :available_books, :borrowed_books

  def initialize(name)
    @name = name
    @books = []
    @available_books = []
    @borrowed_books = []
  end

  def register_new_book(title, author)
    book = Book.new(title, author, rand(1000))
    @books << book
    @available_books << book
  end

  def check_out_book(book_id, borrower)
    if borrower.book_borrowed == nil
      false
      new_book = ''
      self.books.each { |book|
        if book.id == book_id
          new_book = book
        end
      }
      if borrower.any_late_books? == false
        if new_book.status == 'available'
          new_book.check_out
          borrower.book_that_was_borrowed(new_book)
          new_book.borrowing_book(borrower)
          self.available_books.delete(new_book)
          self.borrowed_books << new_book
          new_book
        else
          return nil
        end
      else
        return nil
      end
    else
      return nil
    end
  end

  def check_in_book(book)
    new_book = ''
    self.books.each do |pre_book|
      if pre_book == book
        new_book = book
      end
    end
    if new_book.status != 'available'
      new_book.check_in
      new_book.borrowed_by.book_borrowed = nil
      new_book.borrowed_by = nil
      new_book.status = 'available'
      self.available_books << new_book
      self.borrowed_books.delete(new_book)
    else
      return nil
    end
  end

  def get_borrower(book_id)
    self.books.each do |book| 
      if book.id == book_id
        return book.borrowed_by.name
      end
    end
  end

end

=begin
  
- A Book A Book should be able to be marked as checked_out

- You should be able to check a Book's status (e.g. available or checked out)

- You should be able to add new Books to a Library

- A Borrower should be able to check out a Book
  - Checked-out Books should be associated with a Borrower

- Borrowers should be able to check Books back in to the Library (when they're finished with them)

- A Borrower should not be able to check out more than two Books at any given time

- The Library should be able to list available books and borrowed books
  
=end
