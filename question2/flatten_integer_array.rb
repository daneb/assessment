require './custom_errors'
require './validation'
require 'byebug'

module FlattenIntegerArray

  def self.flatten(input_array)
    FlattenIntegerArray::Validation.not_empty_and_is_an_array?(input_array)
    return input_array if FlattenIntegerArray::Validation.flat_array?(input_array)
    FlattenIntegerArray::Validation.valid_input?(input_array)
    iterate_and_flatten_array(input_array, [])
  end

  private
  def self.iterate_and_flatten_array(input_array, result = Array.new)
    return result if input_array.length == 0
    input_array[0].is_a?(Array) ? iterate_and_flatten_array(input_array[0], result) :  result << input_array[0] 
    iterate_and_flatten_array(input_array.drop(1), result)
  end
end