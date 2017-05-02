require_relative 'payload'

module Kagishi
  class Verifier
    attr_reader :token, :payload

    def initialize(token)
      @token = token
    end

    def verify_token
      parse(token)
    end

    def expired_token?
      verify_token
    end

    # options:
    #  - `verify_expiration: false`: ignore expiration
    #  - `leeway: 15 * 60 (seconds)`: have leeway for expiration
    def payload
      parse(token, options: { leeway: exp_leeway })
    end

    def expired_payload?
      payload
    end

    private

      def parse(token, options: {})
        @payload ||= begin
          payload, header = JWT.decode token, secret, true, options
          Payload.new(payload, header: header, token: token)
        rescue JWT::ExpiredSignature
          return nil
        end
      end

      def secret
        Kagishi.config.secret
      end

      def exp_leeway
        15 * 60
      end
  end
end
