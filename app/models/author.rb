class Author < ApplicationRecord

  has_many :articles

  validates :name, presence: true
  validates :surname, presence: true

  def articles_count
    self.articles.count
  end

  def clean_all_my_articles
    self.articles.delete_all
  end

end
