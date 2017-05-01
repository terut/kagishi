require 'time'
require 'jwt'

require_relative 'kagishi/version'
require_relative 'kagishi/configuration'
require_relative 'kagishi/issuer'
require_relative 'kagishi/verifier'

module Kagishi
  def issue_token(email, payload: {})
    Issuer.new(email, payload: payload).issue_token
  end

  def verify_token(token)
    Verifier.new(token).verify_token
  end

  def payload(token)
    Verifier.new(token).payload
  end
end
