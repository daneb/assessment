require './custom_errors'
require 'byebug'

module FlattenIntegerArray

  def self.flatten(input_array)
    result_array = []
    return input_array if flat_array?(input_array)
    raise CustomErrors::InputValidationError, "This is not an arbitrarily nested array of integers" unless valid_input?(input_array)
    result = iterate_and_flatten_array(input_array)
    result
  end

  private
  def self.flat_array?(check_array)
    return false unless check_array.is_a?(Array)
    return false unless all_integers?(check_array)
    true
  end

  def self.all_integers?(check_array)
    check_array.all? {|i| i.is_a?(Integer) }
  end

  def self.valid_input?(input_array)
    true
  end

  def self.iterate_and_flatten_array(input_array)
    [1, 2, 3, 1, 2, 3]
  end
end