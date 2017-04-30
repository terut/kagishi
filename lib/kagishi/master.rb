module Kagishi
  class Master
    def issue_token(email, payload: {})
      new_payload = payload.merge({ email: email, exp: Time.now.utc.to_i + ttl })
      JWT.encode new_payload, secret, algorithm
    end

    def verify_token(token)
      begin
        payload, header = parse(token)
      rescue JWT::ExpiredSignature
        nil
      end

      payload
    end

    def payload(token)
      payload, header = parse(token, options: { verify_expiration: false })
      payload
    end

    private

      def parse(token, options: {})
        JWT.decode token, secret, true, options
      end

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
