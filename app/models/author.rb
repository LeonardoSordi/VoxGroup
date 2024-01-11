class Author < ApplicationRecord

  has_many :articles

  def articles_count
    articles.count
  end


end
