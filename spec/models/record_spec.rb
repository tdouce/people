require 'rails_helper'

describe Record do
  describe '#new' do
    let(:last_name) { 'some_last_name' }
    let(:first_name) { 'some_first_name' }
    let(:gender) { 'some_gender' }
    let(:favorite_color) { 'some_favorite_color' }
    let(:date_of_birth) { '2020/01/01' }
    let(:hash) do
      {
        last_name: last_name,
        first_name: first_name,
        gender: gender,
        favorite_color: favorite_color,
        date_of_birth: date_of_birth,
      }
    end

    it 'can be initialized with a hash' do
      response = described_class.new(hash)

      expect(response.first_name).to eq(first_name)
      expect(response.last_name).to eq(last_name)
      expect(response.gender).to eq(gender)
      expect(response.favorite_color).to eq(favorite_color)
      expect(response.date_of_birth).to eq(Date.parse(date_of_birth))
    end
  end
end