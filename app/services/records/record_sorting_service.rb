module Records
  class RecordSortingService
    def initialize(records:)
      @records = records
    end

    # NOTE: TKD 2020/10/07
    # Returns records sorted ascending by gender, then sorted descending by last_name
    def sort_by_gender_by_last_name
      records.sort do |a,b|
        comparison = a.gender <=> b.gender

        if comparison.zero?
          comparison = b.last_name <=> a.last_name
        end

        comparison
      end
    end

    # NOTE: TKD 2020/10/07
    # Returns records sorted ascending
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
