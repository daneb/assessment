require 'json'
require './helpers/json_validation'
require './helpers/data_objects'

module Adaptor
  class JSONTextFile
    attr_reader :textfile_location

    def initialize(textfile_location)
      @textfile_location = textfile_location
    end

    def load_customers
      safe_retrieval_of_customers
    end

    private
    def safe_retrieval_of_customers
      file_contents = read_file
      return Helpers::StatusEnvelope.new({}, "Datasource empty") if file_contents.empty?
      json_validator = Helpers::JSONValidation.new(file_contents)
      return JSON.parse(file_contents) if json_validator.valid_json?
      JSON.parse(json_validator.reformat_to_remove_multiple_json_root)
    rescue  JSON::ParserError => e
      Helpers::StatusEnvelope.new(e.to_s, "Corrupt data source - unable to parse")
    end

    def read_file
      IO.readlines(@textfile_location)
    end
  end
end
