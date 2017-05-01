module Kagishi
  module Configurable
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def config
        @configuration ||= Configuration.new
      end

      def configure
        yield(config)
      end
    end
  end

  class Configuration
    def self.default_options
      @default_options ||= {
        algorithm: 'HS256',
        ttl: 15 * 60,
        secret: ''
      }
    end

    def initialize
      reset
    end

    def reset
      self.class.default_options.each do |k, v|
        instance_variable_set(:"@#{k}", v)
      end
    end

    attr_accessor *default_options.keys
  end
end
