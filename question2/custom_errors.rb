module FlattenIntegerArray
  module CustomErrors
    class InputValidationError < StandardError
      def initialize(message)
        super(message)
      end
    end

    def self.raise_validation_exception
      notification = "This is not an arbitrarily nested array of integers"
      raise InputValidationError, notification
    end
  end
end
