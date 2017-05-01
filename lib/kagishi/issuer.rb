module Kagishi
  class Issuer
    attr_reader :email, :payload

    def initialize(email, payload: {})
      @email = email
      @payload = payload
    end

    def issue_token
      new_payload = payload.merge({ email: email, exp: Time.now.utc.to_i + ttl })
      JWT.encode new_payload, secret, algorithm
    end

    private

      def algorithm
        Kagishi.configuration.algorithm
      end

      def secret
        Kagishi.configuration.secret
      end

      def ttl
        Kagishi.configuration.ttl
      end
  end
end
