ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors, with: :threads)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
    setup do
      TranslateArticle.class_eval do
        define_method(:translate_service, -> {"translation string"})
      end
    end

    FactoryBot.define do
      factory :author do
        name {"Nome autore"}
        surname {"Cognome autore"}
      end

      factory :article do
        title {"titolo articolo"}
        body {"testo articolo italiano"}
        status {"public"}
        language {"it"}
        author { create(:author) }
      end

      factory :comment do
        commenter {author.key}
        body {"body commento"}
        status {"public"}
        article {create {:article}}
      end

    end

  end
end
