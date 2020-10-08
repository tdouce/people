module Records
  class RecordFileService
    def self.parse_files(file_paths:, record_file_service_klass: Records::RecordFileService)
      records = file_paths.flat_map do |file_path|
        record_file_service_klass.parse_file(file_path: file_path)
      end

      records
    end

    def self.parse_file(file_path:,
                        file_klass: File,
                        record_parsing_service_klass: Records::RecordParsingService,
                        record_klass: Record)

      record_strings = file_klass.read(file_path).split("\n")

      records = record_strings.map do |record_string|
        record_parsing_service = record_parsing_service_klass.new(record_string: record_string)
        parsed_record = record_parsing_service.parse

        record_klass.new(parsed_record)
      end

      records
    end
  end
end