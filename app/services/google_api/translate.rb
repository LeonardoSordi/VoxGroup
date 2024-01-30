require "google/cloud/translate/v2"

module GoogleApi
  class Translate

    attr_reader :errors

    def initialize
      @errors=[]
      super
    end

    ENV["GOOGLE_APPLICATION_CREDENTIALS"] = "config/credenziali-Google-Translate-api.json"

    #attempts calling client 10 times before returning error
    (1..10).each { |i|
      @client = Google::Cloud::Translate::V2.new
      break if @client != nil
    }

    puts @client.inspect

    def self.call_translation(from_text, from_language, to_language)
      if @client==nil
        @errors.push("Failed to establish connection with Google client")
        false
      end
      @client.translate from_text, to: to_language, from: from_language
    end

  end
end
