module DuoUniversalRails
  class Request
    attr_reader :client
    
    def initialize(client)
      @client = client
    end

    def get_request(url, params: {}, headers: {})
      handle_response client.connection.get(url, params, default_headers.merge(headers))
    end

    def post_request(url, params: {})
      response = client.connection.post(url) do |req|
        req.params = params
      end

      handle_response response
    end

    
    def default_headers
      # {Authorization: "Bearer #{client.api_key}"}
    end

    def handle_response(response)
      message = response.body["error"]

      case response.status 
      when 400
        raise Error, message
      when 401
        raise Error, message
      when 403
        raise Error, message
      when 404
        raise Error, message
      when 429
        raise Error, message
      when 500
        raise Error, message
      end

      response
    end
  end
end