require "faraday"
require "faraday_middleware"
require 'jwt'

module DuoUniversalRails
  class Client

    attr_reader :client_id, :client_secret, :api_hostname, :redirect_uri, :state, :time_now, :adapter

    def initialize(client_id:, client_secret:, api_hostname:, redirect_uri:, time_now: Time.now, state: Client.generate_state, adapter: Faraday.default_adapter)
      @client_id = client_id
      @client_secret = client_secret
      @api_hostname = api_hostname
      @redirect_uri = redirect_uri
      @time_now = time_now
      @state = state
      @adapter = adapter
    end

    class << self 
      def generate_state 
          # Generate JTI_LENGTH length random value
          SecureRandom.alphanumeric(Constant::JTI_LENGTH)
      end

    end

    def https_api_hostname 
      "https://#{api_hostname}"
    end

    def health_check_path
      Constant::OAUTH_V1_HEALTH_CHECK_ENDPOINT
    end

    def health_check_url
      [https_api_hostname, health_check_path].join("")
    end

    def auth_path
      Constant::OAUTH_V1_AUTHORIZE_ENDPOINT
    end

    def auth_url
      [https_api_hostname, auth_path].join("")
    end

    def token_path
      Constant::OAUTH_V1_TOKEN_ENDPOINT
    end

    def token_url
      [https_api_hostname, token_path].join("")
    end

    def time_now_in_sec 
      time_now.to_i
    end

    def expire_in_sec
      time_now_in_sec + Constant::FIVE_MINUTES_IN_SECONDS
    end

    def health_check
      HealthCheckRequest.new(self)
    end

    def auth 
      AuthRequest.new(self)
    end

    def token 
      TokenRequest.new(self)
    end

    # The secret must be a string. A JWT::DecodeError will be raised if it isn't provided.
    def create_jwt_payload(payload:)
      JWT.encode payload, client_secret, Constant::SIG_ALGORITHM
    end

    def decode_jwt_token(token: nil)
      JWT.decode token, client_secret, true, { algorithm: Constant::SIG_ALGORITHM }
    end 

    def connection 
      @connection ||= Faraday.new(https_api_hostname) do |f|
        f.adapter adapter # adds the adapter to the connection, defaults to `Faraday.default_adapter`
      end
    end

    def inspect
      "#<DuoUniversalRails::Client>"
    end

  end
end
