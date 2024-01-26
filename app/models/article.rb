class Article < ApplicationRecord

  include Visible

  has_many :comments, dependent: :destroy

  /validates statement is used to express a NOT NULL condition on an object field/
  validates :title, presence: true
  validates :body, presence: true, length: { minimum: 10 }
  validates :author_id, presence: true
  validates :language, presence: true

  belongs_to :author

  after_create :is_english
  after_create :create_english_version, unless: :is_english


  def create_english_version
    translated_article = self.dup
    TranslateArticle.call_translator(translated_article, "it", "en")
    translated_article.save
  end
  def is_english
    if self.language=="en"
      true
    else
      false
    end
  end


end
