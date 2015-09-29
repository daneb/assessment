module Adaptor
  class JSONTextFile
    attr_reader :textfile_location

    def initialize(textfile_location)
      @textfile_location = textfile_location
    end

    def load_customers
      []
    end

    private
    def read_file

    end
  end
end
