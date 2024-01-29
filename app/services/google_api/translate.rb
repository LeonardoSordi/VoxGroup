require "google/cloud/translate/v2"

module GoogleApi
  class Translate

    ENV["GOOGLE_APPLICATION_CREDENTIALS"] = "config/credenziali-Google-Translate-api.json"

    @client = Google::Cloud::Translate::V2.new

    def self.call_translation(from_text, from_language, to_language)
      @client.translate from_text, to: to_language, from: from_language
    end
  end
end
