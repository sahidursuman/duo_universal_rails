module DuoUniversalRails
  class HealthCheckRequest < Request 
    

    def ping
      parse_response post_request([client.health_check_path].join(""), params: health_check_params)
    end


    def health_check_params
      {
        client_id: client.client_id,
        client_assertion: jwt_client_assertion
      }
    end


    # The Client ID (or Integration key) from the application's page in the Duo Admin Panel.
    # key = iss, TYPE = string, REQUIRED = Yes
    
    # This should match the above iss value.
    # key = sub, TYPE = string, REQUIRED = Yes
    
    # This field must match the expected base URL where the request was sent, 
    # using the “API hostname" from the application's page in the 
    # Duo Admin Panel: https://{api_hostname}/oauth/v1/health_check.
    # key = aud, TYPE = string, REQUIRED = Yes
    
    # The time at which the request you are sending should expire. Duo recommends an exp value of five minutes. 
    # The timestamp format should be in seconds from Unix epoch.
    # key = exp, TYPE = string, REQUIRED = Yes
    
    # This should be a sufficiently random value unique to each JWT.
    # key = jti, TYPE = string, REQUIRED = Yes
    
    # The time at which the JWT was created.
    # key = iat, TYPE = Integer, REQUIRED = No
      
    def build_payload_params
      {
          iss: client.client_id,
          sub: client.client_id,
          aud: client.health_check_url,
          exp: client.expire_in_sec,
          jti: client.state,
          iat: client.time_now_in_sec
      }
    end

    def jwt_client_assertion
      client.create_jwt_payload(payload: build_payload_params)
    end

    
    def parse_response(request)
      str_to_json = JSON.parse(request.body)
      response = Object.new(str_to_json)

      if response.stat == "OK"
        {
          status: true,
          message: "Success"
        }
      elsif response.stat == "FAIL"
        msg = "Status: Fail, code: #{response.code}, message: #{response.message}"
        {
          status: false,
          message: msg
        }
      else
        {
          status: false,
          message: "Someting went wrong!"
        }
      end
    end
    

  end
end