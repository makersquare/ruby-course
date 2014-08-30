
class Book
  attr_reader :author, :title

  def initialize(title=nil, author=nil, year_published=nil, edition=nil)
    @title = title
    @author = author
    @year_published = year_published
    @edition = edition
    @reviews = {}
  end

  def correct_info(type, correction)
    
    # STAR # There might be a better way to do this correction
    case type
    when "title"
      @title = correction
    when "author"
      @author = correction
    when "year_published"
      @year_published = correction
    when "edition"
      @edition = correction
    end
  end

  def add_review(user,review)
    @reviews[user] = review
  end

  def check_reviews
    @reviews.each do |reviewer,review_object|
      puts "#{reviewer.name} gave #{@title} #{review_object.stars} stars",""
      puts "Their review:"
      puts "#{review_object.review}"
    end
  end
end


class Review
  attr_reader :stars, :review
  def initialize(stars=nil,review=nil)
    @stars = stars
    @review = review
  end

  def add_review(review)
    @review = review
  end

  def add_rating(stars)
    @stars = stars
  end
end


class LibraryBookWrap
  attr_reader :book
  attr_accessor :borrowers_list_in_order, :due_in, :id

  def initialize(book)
    @book = book
    @borrowers_list_in_order = []
    @due_in = nil
    @id = id
  end

  def status
    length = @borrowers_list_in_order.count
    if length == 0
      "available"
    elsif length == 1
      "checked out"
    elsif length > 1
      "checked out and on hold"
    end
  end

  def overdue?
    return false if @due_in == nil
    @due_in < Time.now
  end
        

class BorrowerCard
  @@id_generator = 0

  attr_reader :name
  attr_accessor :number_of_books_borrowed, :books_borrowed
  def initialize(name)
    @name = name
    @books_borrowed = []
    @number_of_books_borrowed = 0
  end

  def not_overdue?
    @books_borrowed.each do |book|
      book.check_overdue
    end
  end

end


class Library
  attr_accessor :books
  @@BORROWING_TIME = 10 #7*24*60*60

  def initialize(name="")
    @name = name
    @books = []
    @id_giver = 0
    @books_and_their_borrowers = {}
    @borrowers_and_their_books = Hash.new { |hash,key| hash[key] = [] }
  end

  def register_new_book(title, author)
    book = Book.new(title,author)
    @id_giver += 1
    book.id = @id_giver
    @books << book
    book
  end

  def add_book(book)
    @id_giver += 1
    book.id = @id_giver
    @books << book
    book
  end

  def check_out_book(book_id, borrower)
    checking_out = @books.find {|book| book.id == book_id}
    if borrower.number_of_books_borrowed < 2 && !(borrower_has_overdue_books?(borrower))
      if checking_out.check_out
        borrower.number_of_books_borrowed += 1
        @books_and_their_borrowers[checking_out] = borrower
        @borrowers_and_their_books[borrower] = @borrowers_and_their_books[borrower] << checking_out
        borrower.books_borrowed << checking_out
        checking_out.due_in = Time.now + @@BORROWING_TIME
        checking_out
      else
        puts "#{checking_out} is currently out to #{borrower.name} and is due back by #{checking_out.due_in}."
      end
    else 
      nil
    end
  end

  def get_borrower(book_id)
    @books_and_their_borrowers.each {|book,borrower| return borrower if book.id == book_id}
  end

  def check_in_book(book)
    borrower = get_borrower(book.id)
    borrower.number_of_books_borrowed -= 1
    borrower.books_borrowed.delete(book)
    book.due_in = nil
    @books_and_their_borrowers[book] = nil
    @borrowers_and_their_books[borrower].delete(book)
    book.check_in
    if !(book.on_hold.empty?)
      check_out_book(book.id, book.on_hold.shift)
    end
  end

  def put_on_hold(book,borrower)
    if book.status == "checked_out"
      book.on_hold << borrower
      puts "#{borrower.name} is number #{book.on_hold.length} on the hold list for #{book.title}."
    end
  end

  def available_books
    @books.select { |book| book.status == "available" }
  end

  def borrowed_books
    @books.select { |book| book.status == "checked_out" }
  end

  def overdue_books
    @books.select do |book|
      next if book.due_in == nil
      book.overdue = true if book.due_in < Time.now
    end
  end

  def borrower_has_overdue_books?(borrower)
    overdue_books
    @borrowers_and_their_books[borrower].each do |book|
      if book.overdue
        return true
      end
    end
    return false
  end

end