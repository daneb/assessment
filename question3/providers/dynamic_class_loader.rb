require './providers/json_text_file.rb'

module Provider
  def self.class_from_string(class_name)
    eval(class_name).new
  end
end