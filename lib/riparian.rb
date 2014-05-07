require 'openssl'
require 'net/http'
require 'digest/sha1'
require 'riparian/config'
require 'riparian/error'
require 'riparian/session'
require 'riparian/request'
require 'riparian/response'


module Riparian
  def self.user_agent
    "Riparian/#{Riparian::VERSION}"
  end

  def self.http_headers
    {
      'User-Agent'   => user_agent,
      'Content-Type' => 'application/x-www-form-urlencoded'
    }
  end
end
