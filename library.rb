
class Book
  attr_reader :author, :title, :status
  attr_accessor :id, :reviews, :due_in, :on_hold, :overdue


  def initialize(title=nil, author=nil, year_published=nil, edition=nil)
    @title = title
    @author = author
    @id = nil
    @status = "available"
    @year_published = year_published
    @edition = edition
    @reviews = {}
    @due_in = nil
    @overdue = false
    @on_hold = []
  end

  def check_out
    if @status == "available"
      @status = "checked_out"
      return true
    else 
      return false
    end
  end

  def check_in
    @status = "available"
    @overdue = false
  end

  def check_reviews
    @reviews.each do |reviewer,review_object|
      puts "#{reviewer.name} gave #{@title} #{review_object.stars} stars",""
      puts "Their review:"
      puts "#{review_object.review}"
    end
  end

end


class Borrower
  attr_reader :name
  attr_accessor :number_of_books_borrowed, :books_borrowed
  def initialize(name)
    @name = name
    @books_borrowed = []
    @number_of_books_borrowed = 0
  end

  def review_book(book,stars,review)
    temp = Review.new(stars,review)
    book.reviews[self] = temp
  end

  def not_overdue?
    @books_borrowed.each do |book|
      book.check_overdue
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

class Library
  attr_accessor :books
  @@BORROWING_TIME = 1 #7*24*60*60

  def initialize(name="")
    @name = name
    @books = []
    @id_giver = 0
    @books_and_their_borrowers = {}
    @borrowers_and_their_books = Hash.new { [] }
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
        puts "#{checking_out.title} is currently out to #{@books_and_their_borrowers[checking_out].name} and is due back by #{checking_out.due_in}."
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

  # ALTERNATES WITH NICK

  # def check_out_book(book_id,borrower)
  #   if @borrowed_books.values.count(borrower) >= 2 #!! look at what Array#count can do
  #   book = @books.find do |b|
  #     b.id == book_id
  #   end

  #   if book.check_out
  #     @borrowed_books[book.id] = borrower.name 
  #     # Class hash to store ID to borrower
  #     book
  #   else
  #     nil
  #   end
  # end

  # But you can take out line 181 and put it in a helper method
  # def check_out_book...
  #   return nil if ineligible_borrower?

  # def ineligible_borrower?(borrower)
  #   @borrowed_books.values.count(borrower) >= 2
  #   # and now we can also see if they have overdue books
  # end

  # careful of nested ifs!


end