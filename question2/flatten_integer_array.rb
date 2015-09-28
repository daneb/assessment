require './custom_errors'
require 'byebug'

module FlattenIntegerArray

  def self.flatten(input_array)
    result_array = []
    return input_array if empty_or_flat_array?(input_array)
    valid_input?(input_array)
    result = iterate_and_flatten_array(input_array, [])
    result
  end

  private
  def self.empty_or_flat_array?(check_array)
    empty?(check_array)
    flat_array?(check_array)
  end

  def self.empty?(check_array)
     FlattenIntegerArray::CustomErrors.raise_validation_exception if check_array.empty?
  end

  def self.flat_array?(check_array)
    return false unless check_array.is_a?(Array)
    return false unless only_integers_no_array?(check_array)
    true
  end

  def self.only_integers_no_array?(check_array)
    check_array.all? {|i| i.is_a?(Integer) }
  end

  def self.all_integers?(check_array)
    check_array.all? {|i| i.is_a?(Array) ? all_integers?(i) : i.is_a?(Integer) }
  end

  def self.valid_input?(input_array)
    FlattenIntegerArray::CustomErrors.raise_validation_exception unless all_integers?(input_array)
  end

  def self.iterate_and_flatten_array(input_array, result = Array.new)
    return result if input_array.length == 0
    input_array[0].is_a?(Array) ? iterate_and_flatten_array(input_array[0], result) :  result << input_array[0] 
    iterate_and_flatten_array(input_array.drop(1), result)
  end
end