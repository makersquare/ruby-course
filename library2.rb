class Book
  attr_reader :author, :title, :reviews

  def initialize(title: nil, author: nil, year_published: nil, edition:nil)
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
      puts "#{reviewer.name} gave #{@title} #{review_object.stars} stars"
      puts "Their review:"
      puts "#{review_object.review}"
    end
  end
end


class Review
  attr_reader :stars, :review
  def initialize(stars: nil,review: nil)
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


class LibraryWrapper
  attr_reader :book
  attr_accessor :due_in, :borrowers_list_in_order

  def initialize(book)
    @book = book
    @borrowers_list_in_order = []
    @due_in = nil
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

  def get_borrower
    @borrowers_list_in_order.first
  end

  def add_borrower(borrower)
    @borrowers_list_in_order << borrower
  end  
end
        

class BorrowerCard
  @@BORROWING_LIMIT = 2

  attr_reader :name, :email_address
  attr_accessor :books_borrowed

  def initialize(name,address: nil)
    @name = name
    @books_borrowed = []
    email_address = address
  end

  def eligible_borrower?
    @books_borrowed.each do |book_wrapper|
      if book_wrapper.overdue? 
        return false
      end
    end
    if @books_borrowed.count >= @@BORROWING_LIMIT
      return false
    end
    true
  end
end


class Library
  attr_accessor :books, :borrower_cards

  @@BORROWING_TIME = 7*24*60*60
  @@borrower_id_generator = 0
  @@book_id_generator = 0
  

  def initialize(name: nil)
    @name = name
    @books = {} #book id => book_wrapper_object
    @borrower_cards = {} #borrower id => borrower_object
  end

  def issues_borrower_card(borrower_card)
    @@borrower_id_generator += 1
    @borrower_cards[@@borrower_id_generator] = borrower_card
  end

  def register_new_book(library_book)
    @@book_id_generator += 1
    @books[@@book_id_generator] = library_book
  end

  def check_out_book(book_id, borrower_id)
    borrower_obj = @borrower_cards[borrower_id]
    book_obj = @books[book_id]
    if !(borrower_obj.eligible_borrower?)
      return "Ineligible to borrow at this time."
    end
    if (book_obj.status == "checked out" || book_obj.status == "checked out and on hold")
      return "That book is currently unavailable. Would you like to place a hold?"
    end
    borrower_obj.books_borrowed << @books[book_id]
    book_obj.add_borrower(borrower_obj)
    book_obj.due_in = Time.now + @@BORROWING_TIME
    book_obj
   # binding.pry
  end

  def get_borrower(book_id)
    @books[book_id].borrowers_list_in_order.first
  end

  def check_in_book(book_id)
    borrower = @books[book_id].borrowers_list_in_order.shift
    @books[book_id].due_in = nil

    borrower.books_borrowed.delete(@books[book_id])
    if !(@books[book_id].borrowers_list_in_order.empty?)
      check_out_book(book_id, @borrower_cards.key(@books[book_id].borrowers_list_in_order.first))
      email_borrower(book_id, @borrower_cards.key(@books[book_id].borrowers_list_in_order.first))
    end
  end

  def put_on_hold(book_id,borrower_id)
    @books[book_id].add_borrower(@borrower_cards[borrower_id])
    puts "#{borrower_cards[borrower_id].name} is number #{@books[book_id].borrowers_list_in_order.length} on the hold list for #{@books[book_id].book.title}."
  end

  def available_books
    @books.values.select { |book| book.status == "available" }
  end

  def borrowed_books
    @books.values.select { |book| book.status == "checked out" || book.status == "checked out and on hold" }
  end

  def overdue_books
    @books.values.select { |book| book.overdue?}
  end

  def email_borrower(book_id, borrower_id)
    # send to @borrower_cards[borrower_id].email_address
    # about @books[book_id].book.title
  end
end