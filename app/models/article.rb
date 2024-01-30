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
    translate = TranslateArticle.call_translator(self.dup, "it", "en")
    if translate.saved?
      return true
    else
      self.errors.add(:to_language, translate.errors.join(", "))
      render json: self.errors, status: :unprocessable_entity
      return false
    end
  end

  def is_english
    self.language == "en"
  end


end
