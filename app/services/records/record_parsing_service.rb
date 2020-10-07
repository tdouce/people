module Records
  class RecordParsingService
    def initialize(record_string:)
      @record_string = record_string
    end

    def parse
      last_name, first_name, gender, favorite_color, date_of_birth = record_string.split(delimiter)

      {
        last_name: last_name,
        first_name: first_name,
        gender: gender,
        favorite_color: favorite_color,
        date_of_birth: date_of_birth
      }
    end

    private

    attr_reader :record_string

    def delimiter
      case
      when record_string.include?(',')
        ','
      when record_string.include?('|')
        '|'
      else
        ' '
      end
    end
  end
end