module Records
  class RecordSortingService
    def initialize(records:)
      @records = records
    end

    def sort_by_gender
      records.sort_by {|record| record.gender }
    end

    def sort_by_date_of_birth
      records.sort_by {|record| record.date_of_birth }
    end

    def sort_by_last_name
      records.sort_by {|record| record.last_name }
    end

    private

    attr_reader :records
  end
end
