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
    translated_article = TranslateArticleJob.perform_now(self)
    if translated_article != true
      self.errors.add(translated_article)
    end
  end

  def is_english
    self.language == "en"
  end


end
