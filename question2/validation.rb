module FlattenIntegerArray
  module Validation
    def self.not_empty_and_is_an_array?(check_array)
      FlattenIntegerArray::CustomErrors.raise_validation_exception unless (check_array.is_a?(Array) && check_array.length > 0)
    end

    def self.valid_input?(check_array)
      FlattenIntegerArray::CustomErrors.raise_validation_exception unless all_integers?(check_array)
    end

    def self.flat_array?(check_array)
      return false unless check_array.is_a?(Array)
      return false unless only_integers_no_array?(check_array)
      true
    end

    private
    def self.only_integers_no_array?(check_array)
      check_array.all? {|i| i.is_a?(Integer) }
    end

    def self.all_integers?(check_array)
      check_array.all? {|i| i.is_a?(Array) ? all_integers?(i) : i.is_a?(Integer) }
    end
  end
end
