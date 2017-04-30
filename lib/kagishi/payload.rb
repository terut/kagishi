module Kagishi
  class Payload
    attr_reader :header
    attr_reader :raw
    def initialize(payload = {}, header: {})
      @raw = symbolize_keys(payload)
      @header = symbolize_keys(header)
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
