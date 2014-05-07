require 'uri'

module Riparian
  class Config
    def self.conduit_uri
      URI.parse host
    end

    def self.host
      @@config[:host]
    end

    def self.credentials
      @@config[:credentials]
    end

    private

    def self.config
      @@config = yield({})
    end
  end
end
