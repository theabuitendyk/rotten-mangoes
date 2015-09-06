class Movie < ActiveRecord::Base

  has_many :reviews

  validates :title, :director, :description, :poster_image_url, :release_date,
    presence: true

  validates :runtime_in_minutes,
    numericality: { only_integer: true }

  validate :release_date_is_in_the_future

  def review_average
    if reviews.size == 0
      return 0
    else
      (reviews.sum(:rating_out_of_ten)/reviews.size)*10
    end
  end

  def total_reviews
    reviews.count
  end

  def fresh_reviews
    reviews.where('rating_out_of_ten >= ?', 5).count
  end

  def rotten_reviews
    reviews.where('rating_out_of_ten < ?', 5).count
  end

  protected

  def release_date_is_in_the_future
    if release_date.present?
      errors.add(:release_date, "should probably be in the future") if release_date < Date.today
    end
  end

end