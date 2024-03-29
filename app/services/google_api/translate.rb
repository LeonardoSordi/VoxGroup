require "google/cloud/translate/v2"

module GoogleApi
  class Translate

    attr_reader :errors
    attr_accessor :client

    def initialize

    @errors=[]
    @client = client_setup

    end

    def client_setup


      ENV["GOOGLE_APPLICATION_CREDENTIALS"] = "config/credenziali-Google-Translate-api.json"

      begin
        #attempts calling client 5 times before returning error
        client_init = Google::Cloud::Translate::V2.new(retries: 5)
        #adds possible errors to error array
      rescue Error => e
        @errors.push "Failed to establish connection with Google client: #{e.message}"
      end

      if client_init==nil && @errors.size == 0
        @errors.push("Failed to establish connection with Google client")
      end
      client_init
    end



    def call_translation(from_text, from_language, to_language)
      response = false

      if @client==nil
        @errors.push("Could not translate article: client is nil")

      else
        begin
          response = @client.translate from_text, to: to_language, from: from_language
        rescue Error => e
          @errors.push "Could not translate article: #{e.message}"
        end
      end
      response
    end



  end
end
