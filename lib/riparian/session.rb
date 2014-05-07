module Riparian
  class Session
    def call(method, data = {})
      Riparian::Request.new(self, method, data).response
        .result
    end

    def connected?
      @session_key && @connection_id
    end

    def session
      {
        'sessionKey'   => @session_key,
        'connectionID' => @connection_id
      }
    end

    def connect
      fail 'Already connected.' if connected?

      certificate = Riparian::Config.credentials['cert']
      auth_token  = Time.now.to_i

      data = {
        'authToken'     => auth_token,
        'authSignature' => hash(auth_token, certificate),
        'user'          => Riparian::Config.credentials['user']
      }

      response = call 'conduit.connect', data

      p response

      @connection_id = response['connectionID']
      @session_key   = response['sessionKey']
    end

    private

    def hash(auth_token, certificate)
      Digest::SHA1.hexdigest "#{auth_token}#{certificate}"
    end
  end
end
