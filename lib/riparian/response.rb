require 'json'

module Riparian
  class Response
    def initialize(response)
      @response = JSON.parse response

      fail(Riparian::Error, error) unless valid?

      @result = @response['result']
    end

    def result; @result; end

    def valid?
      @response['error_code'].nil?
    end

    def error
      "#{@response['error_info']} (#{@response['error_code']})"
    end
  end
end
