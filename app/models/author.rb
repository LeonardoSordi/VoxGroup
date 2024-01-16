class Author < ApplicationRecord

  before_save :generate_key

  has_many :articles

  validates :name, presence: true
  validates :surname, presence: true

  def articles_count
    self.articles.count
  end

  def clean_all_my_articles
    self.articles.delete_all
  end

  def generate_key
    @author_key = Array.new(20){[*"A".."Z", *"0".."9"].sample}.join
    while Author.find_by(key: @author_key).present? do
      @author_key = Array.new(20){[*"A".."Z", *"0".."9"].sample}.join
    end
    self.key = @author_key
  end
end
