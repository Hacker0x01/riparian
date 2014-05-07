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

class Riparian::Test
  def self.connect!
    certificate = Riparian::Config.credentials['cert']
    auth_token  = Time.now.to_i

    data = {
      'authToken'     => auth_token,
      'authSignature' => hash(auth_token, certificate),
      'user'          => Riparian::Config.credentials['user']
    }

    session = Riparian::Session.new

    response = session.call 'conduit.connect', data

    Riparian::Session.new response['connectionID'],
      response['sessionKey']
  end

  private

  def self.hash(auth_token, certificate)
    Digest::SHA1.hexdigest "#{auth_token}#{certificate}"
  end
end

session = Riparian::Test.connect!

puts session.call 'differential.getrevision', revision_id: '1337'

