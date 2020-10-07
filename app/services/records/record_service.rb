module Records
  class RecordService
    def self.create!(parsed_record:, record_klass: Record, database_klass: MemoryDb)
      record = record_klass.new(parsed_record)

      database_klass.add_record(record: record)

      record
    end
  end
end