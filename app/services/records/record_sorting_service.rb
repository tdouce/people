module Records
  class RecordSortingService
    def initialize(records:)
      @records = records
    end

    # NOTE: TKD 2020/10/07
    # Returns records sorted ascending by gender, then sorted ascending by last_name
    def sort_by_gender_by_last_name
      records.sort do |a,b|
        comparison = a.gender <=> b.gender

        if comparison.zero?
          comparison = a.last_name <=> b.last_name
        end

        comparison
      end
    end

    # NOTE: TKD 2020/10/07
    # Returns records sorted ascending
    def sort_by_gender
      records.sort_by {|record| record.gender }
    end

    # NOTE: TKD 2020/10/07
    # Returns records sorted ascending
    def sort_by_date_of_birth
      records.sort_by {|record| record.date_of_birth }
    end

    def sort_by_last_name(sort_direction: :asc)
      records.sort do |a, b|
        if sort_direction == :asc
          a.last_name <=> b.last_name
        elsif sort_direction == :desc
          b.last_name <=> a.last_name
        end
      end
    end

    private

    attr_reader :records
  end
end
