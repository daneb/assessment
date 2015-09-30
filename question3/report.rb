require './helpers/data_objects'

module Report
  def self.generate_report(customers_within_radius)
    report_objects = transform_for_report(customers_within_radius)
    sorted = sort_ascending(report_objects)

  end

  def self.transform_for_report(customers_within_radius)
    report_objects = []
    customers_within_radius.each do |customer| 
      report_objects << Helpers::CustomerReport.new(customer["user_id"], customer["name"])
    end
    report_objects
  end

  def self.sort_ascending(report_objects)
    report_objects.sort_by { |report_object| report_object.user_id }
  end

  def self.write_report_to_disk(report_objects)
    @config = YAML.load_file("config/config.yml")
    File.open(@config["nearby"]["report"], 'w') { |file|
      report_objects.each do |report_object|
        file.write("#{report_object.name}, #{report_object.user_id}\n")
      end
    } 
  end
end