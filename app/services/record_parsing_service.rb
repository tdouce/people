class RecordParsingService
  def initialize(record_string:)
    @record_string = record_string
  end
  
  def to_h
    last_name, first_name, gender, favorite_color, date_of_birth = record_string.split(delimiter)

    {
      last_name: last_name,
      first_name: first_name,
      gender: gender,
      favorite_color: favorite_color,
      date_of_birth: Date.parse(date_of_birth)
    }
  end
  
  private

  attr_reader :record_string

  def delimiter
    if record_string.include?(',')
      ','
    elsif record_string.include?('|')
      '|'
    elsif record_string.include?(' ')
      ' '
    else
      raise "Unknown delimiter"
    end
  end
end