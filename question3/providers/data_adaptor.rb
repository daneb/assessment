require_relative 'dynamic_class_loader.rb'
require_relative 'json_text_file.rb'

class DataAdaptor
  attr_reader :datasource, :config

  def initialize
    byebug
    @config = YAML.load_file("config/config.yml")
    @datasource = Provider.class_from_string("Adaptor::JSONTextFile")
  end

  def retrieve_customers
    @datasource.load_customers
  end
end