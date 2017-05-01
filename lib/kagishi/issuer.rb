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
        Kagishi.config.algorithm
      end

      def secret
        Kagishi.config.secret
      end

      def ttl
        Kagishi.config.ttl
      end
  end
end
