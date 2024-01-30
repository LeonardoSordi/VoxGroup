require "google/cloud/translate/v2"

module GoogleApi
  class Translate

    attr_accessor :errors
    attr_reader :client

    def initialize

    @errors=[]
    @client = client_setup

    end

    def client_setup
      ENV["GOOGLE_APPLICATION_CREDENTIALS"] = "config/credenziali-Google-Translate-api.json"

      #attempts calling client 10 times before returning error
      client_init = Google::Cloud::Translate::V2.new
      (1..10).each { |i|
        break if client_init != nil
        client_init = Google::Cloud::Translate::V2.new
      }

      if client_init==nil
        @errors.push("Failed to establish connection with Google client")
        false
      else
        client_init
      end
    end

    def call_translation(from_text, from_language, to_language)
      unless @client==nil
        @client.translate from_text, to: to_language, from: from_language
      end
    end
  end
end
