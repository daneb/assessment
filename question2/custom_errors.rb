module FlattenIntegerArray
  module CustomErrors
    class InputValidationError < StandardError
      def initialize(message)
        super(message)
      end
    end
  end
end
