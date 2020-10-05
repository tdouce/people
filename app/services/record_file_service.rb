require 'csv'

class RecordFileService
  def self.parse_files(files:)
    files.flat_map do |file|
      parse(file: file)
    end
  end

  def self.parse(file:)
    lines = File.read(file).split("\n")

    records = lines.map do |line|
      record_parsing_service = RecordParsingService.new(record_string: line)
      record_params = record_parsing_service.to_h
      record = RecordService::Record.new(record_params)

      record
    end

    records
  end
end