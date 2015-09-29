require_relative 'json_text_file.rb'

module Provider
  def self.class_from_string(class_name, params)
    eval(class_name).new(params)
  end
end