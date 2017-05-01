module Kagishi
  class Payload
    attr_reader :raw, :header, :token

    def initialize(payload = {}, header: {}, token: nil)
      @raw = symbolize_keys(payload)
      @header = symbolize_keys(header)
      @token = token
    end

    def email
      raw[:email]
    end

    private

      def symbolize_keys(hash)
        hash.map { |k, v| [k.to_sym, v] }.to_h
      end
  end
end
