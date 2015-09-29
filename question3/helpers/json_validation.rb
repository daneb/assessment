require 'json'

class JSONValidation
  attr_accessor :contents

  def initialize(contents_of_file)
    @contents = contents_of_file
  end

  def reformat_to_remove_multiple_json_root
      remove_multiple_root && add_prepend && add_suffix 
      @contents.join(" ")
  end

  def valid_json?
    return true if JSON.parse(@contents.join(" "))
  rescue JSON::ParserError => e
    false
  end

  private
  def add_prepend
     @contents.insert(0, '{"customers": { "items": [')
  end

  def remove_multiple_root
    @contents.collect! { |line| line << ',' }
    @contents[@contents.length - 1].chop!
  end

  def add_suffix
    @contents.push('] } }')
  end
end
