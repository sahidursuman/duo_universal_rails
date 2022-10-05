module DuoUniversalRails
  class TokenRequest < Request 
    

    def exchange_authorization_code_for_2fa_result(code: client.state, username:)
      request = post_request([client.token_path].join(""), params: request_params(code: code))
      parse_request = JSON.parse(request.body)
      verify_token(token: parse_request["id_token"])[0]
    end


    # This must be equal to the string authorization_code.
    # KEY - grant_type, TYPE - String, REQUIRED - Yes

    # This must be equal to the string code received in the previous response.
    # KEY - code, TYPE - String, REQUIRED - Yes

    # This must be equal to the redirect URI sent in the request to the Authorization Request endpoint /oauth/v1/authorize.
    # KEY - redirect_uri, TYPE - String, REQUIRED - Yes

    # This must be equal to the string value urn:ietf:params:oauth:client-assertion-type:jwt-bearer,
    # KEY - client_assertion_type, TYPE - String, REQUIRED - Yes

    # See below for the required payload fields. See - client_assertion_payload method
    # KEY - client_assertion, TYPE - JWT, REQUIRED - Yes

    # The Client ID (or Integration key) from the application's page in the Duo Admin Panel.
    # KEY - client_id, TYPE - String, REQUIRED - No

    
    def request_params(code:)
      {
        grant_type: 'authorization_code',
        code: code,
        redirect_uri: client.redirect_uri,
        client_assertion_type: Constant::CLIENT_ASSERT_TYPE,
        client_assertion: jwt_client_assertion,
        client_id: client.client_id
      }
    end




    # The Client ID (or Integration key) from the application's page in the Duo Admin Panel.
    # KEY - iss, TYPE - string, REQUIRED - Yes

    # This should match the above iss value.
    # KEY - sub, TYPE - string, REQUIRED - Yes

    # This field must match the expected base URL where the request was sent, using the “API hostname" from the application's page in the Duo Admin Panel: https://{api_hostname}/oauth/v1/token
    # KEY - aud, TYPE - string, REQUIRED - Yes

    # The time at which the request you are sending should expire. 
    # Duo recommends an exp value of five minutes. 
    # The timestamp format should be in seconds from Unix epoch.
    # KEY - exp, TYPE - Integer, REQUIRED - Yes

    # This should be a sufficiently random value unique to each JWT.
    # KEY - jti, TYPE - String, REQUIRED - Yes


    # The time at which the JWT was created.
    # KEY - exp, TYPE - Integer, REQUIRED - No

    def client_assertion_payload
      {
        iss: client.client_id,
        sub: client.client_id,
        aud: client.token_url,
        exp: client.expire_in_sec,
        jti: client.state,
        iat: client.time_now_in_sec
      }
    end

    def jwt_client_assertion
      client.create_jwt_payload(payload: client_assertion_payload)
    end

    
    def verify_token(token:)
      client.decode_jwt_token(token: token)
    end

  end
end