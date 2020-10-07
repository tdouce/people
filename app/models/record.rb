class Record
  attr_reader :last_name, :first_name, :gender, :favorite_color

  def initialize(last_name:, first_name:, gender:, favorite_color:, date_of_birth:)
    @last_name = last_name
    @first_name = first_name
    @gender = gender
    @favorite_color = favorite_color
    @date_of_birth = date_of_birth
  end

  def date_of_birth
    Date.parse(@date_of_birth)
  end
end