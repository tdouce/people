module Records
  class RecordService
    def self.create!(parsed_record:, record_klass: Record, database_klass: MemoryDb)
      record = record_klass.new(parsed_record)

      database_klass.add_record(record: record)

      record
    end

    def self.find_records(sort:, database_klass: MemoryDb, record_sorting_service_klass: Records::RecordSortingService)
      all_records = database_klass.all_records

      record_sorting_service = record_sorting_service_klass.new(records: all_records)

      records = case
                when sort == 'gender'
                  record_sorting_service.sort_by_gender
                when sort == 'birthdate'
                  record_sorting_service.sort_by_date_of_birth
                when sort == 'name'
                  record_sorting_service.sort_by_last_name
                else
                  record_sorting_service.sort_by_gender
                end

      records
    end
  end
end