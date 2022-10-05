module DuoUniversalRails
  class Constant
    CLIENT_ID_LENGTH = 20
    CLIENT_SECRET_LENGTH = 40
    JTI_LENGTH = 36
    MINIMUM_STATE_LENGTH = 22
    MAXIMUM_STATE_LENGTH = 1024
    STATE_LENGTH = 36
    SUCCESS_STATUS_CODE = 200
    FIVE_MINUTES_IN_SECONDS = 300
    # One minute in seconds
    LEEWAY = 60

    SIG_ALGORITHM = 'HS512'

    ERR_USERNAME = 'The username is invalid.'
    ERR_NONCE = 'The nonce is invalid.'
    ERR_CLIENT_ID = 'The Duo client id is invalid.'
    ERR_CLIENT_SECRET = 'The Duo client secret is invalid.'
    ERR_API_HOST = 'The Duo api host is invalid'
    ERR_REDIRECT_URI = 'No redirect uri'
    ERR_CODE = 'Missing authorization code'
    ERR_UNKNOWN = 'An unknown error has occurred.'
    ERR_GENERATE_LEN = 'Length needs to be at least 22'
    
    # ERR_STATE_LEN = ('State must be at least {MIN} characters long and no longer than {MAX} characters').format(
    #     MIN=MINIMUM_STATE_LENGTH,
    #     MAX=MAXIMUM_STATE_LENGTH
    # )

    # API_HOST_URI_FORMAT = "https://{}"
    OAUTH_V1_HEALTH_CHECK_ENDPOINT = "/oauth/v1/health_check"
    OAUTH_V1_AUTHORIZE_ENDPOINT = "/oauth/v1/authorize"
    OAUTH_V1_TOKEN_ENDPOINT = "/oauth/v1/token"
    # DEFAULT_CA_CERT_PATH = os.path.join(os.path.dirname(__file__), 'ca_certs.pem')

    CLIENT_ASSERT_TYPE = "urn:ietf:params:oauth:client-assertion-type:jwt-bearer" 
  end
end
