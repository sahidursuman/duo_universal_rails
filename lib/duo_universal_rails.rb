# frozen_string_literal: true

require_relative "duo_universal_rails/version"

module DuoUniversalRails
  autoload :Error, "duo_universal_rails/error"
  autoload :Constant, "duo_universal_rails/constant"
  autoload :Object, "duo_universal_rails/object"

  autoload :Request, "duo_universal_rails/request"

  autoload :HealthCheckRequest, "duo_universal_rails/requests/health_check_request"
  autoload :AuthRequest, "duo_universal_rails/requests/auth_request"
  autoload :TokenRequest, "duo_universal_rails/requests/token_request"


  autoload :Client, "duo_universal_rails/client"
  
end
