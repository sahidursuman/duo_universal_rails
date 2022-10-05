module DuoUniversalRails
  class AuthRequest < Request 

    def create_url(username:)
      query_params = build_auth_url_query_params(username: username)
      url_query = query_params.to_a.map { |x| "#{x[0]}=#{x[1]}" }.join("&")
      [client.auth_url, "?", url_query].join("")
    end

    def build_auth_url_query_params(username:)
      {
          response_type: 'code',
          client_id: client.client_id,
          request: request_jwt(username: username),
          redirect_uri: client.redirect_uri,
          scope: 'openid'

      }
    end


    # We expect the value code to be present for this field.
    # KEY - response_type, TYPE - string, REQUIRED - Yes
    
    # Must match the value defined above. 
    # Means if you added scope is openid for authoraze params as scope openid then scope should be openid
    # KEY - scope, TYPE - String, REQUIRED - Yes
    
    # The time at which the request you are sending should expire. 
    # Duo recommends an exp value of five minutes. 
    # The timestamp format should be in seconds from Unix epoch.
    # KEY - exp, TYPE - String, REQUIRED - Yes
    
    # The Client ID (or Integration key) from the application's page in the Duo Admin Panel.
    # KEY - client_id, TYPE - String, REQUIRED - Yes
    
    # The URI where the end-user will be redirected after a successful auth. 
    # Must be a well-formed with a valid HTTPS URL and port, using a hostname. 
    # Maximum length: 1024 characters.
    # KEY - redirect_uri, TYPE - String, REQUIRED - Yes


    # A random, cryptographically secure value that the client must maintain throughout the authentication. 
    # We require a length of at least 16 characters and at most 1024 characters.
    # KEY - state, TYPE - String, REQUIRED - Yes
    
    # Unique name for the user in Duo. If a user has aliases in Duo, those are valid to send in this field. 
    # Subject to username normalization as configured for the application in the Admin Panel.
    # KEY - duo_uname, TYPE = String, REQUIRED = Yes
    
    # If provided, this field must match the client_id sent in this payload.
    # KEY - iss, TYPE - String, REQUIRED - No
    
    # This field must match the “API hostname" from the application's 
    # page in the Duo Admin Panel: https://{api_hostname}.
    # KEY - aud, TYPE - String, REQUIRED - No

    # f provided, this must be a random value that is cryptographically secure such that it is unguessable by a third party. 
    # We require a length of at least 16 characters and at most 1024 characters.
    # KEY - nonce, TYPE - String, REQUIRED - No
    
    # If provided and the value is true, 
    # then the authorization code will be returned under the attribute name of duo_code.
    # KEY - use_duo_code_attribute, TYPE - Boolean, REQUIRED - No

    def request_params(username:)
       {
          response_type: 'code',
          scope: 'openid',
          exp: client.expire_in_sec,
          client_id: client.client_id,
          redirect_uri: client.redirect_uri,
          state: client.state,
          duo_uname: username,
          iss: client.client_id,
          aud: client.https_api_hostname,
          use_duo_code_attribute: true
      }
    end

    def request_jwt(username:)
      get_payload = request_params(username: username)
      client.create_jwt_payload(payload: get_payload)
    end




  end
end