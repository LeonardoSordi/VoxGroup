class Article < ApplicationRecord

  include Visible

  has_many :comments, dependent: :destroy

  /validates statement is used to express a NOT NULL condition on an object field/
  validates :title, presence: true
  validates :body, presence: true, length: { minimum: 10 }
  validates :author_id, presence: true

  belongs_to :author

  after_create :translate_article


  def translate_article
    TranslateArticle.call(self)
  end

end
