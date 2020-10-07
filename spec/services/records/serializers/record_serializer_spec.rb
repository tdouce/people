require 'rails_helper'

describe Records::Serializers::RecordSerializer do
  let(:record) do
    instance_double(
      Record,
      last_name: 'some_last_name',
      first_name: 'some_first_name',
      gender: 'some_gender',
      favorite_color: 'some_favorite_color',
      date_of_birth: Date.parse('1985/09/22')
    )
  end

  subject do
    described_class.new(record)
  end

  describe '#parse' do
    let(:expected_response) do
      {
        last_name: record.last_name,
        first_name: record.first_name,
        gender: record.gender,
        favorite_color: record.favorite_color,
        date_of_birth: '09/22/1985'
      }
    end

    it 'serializes the record' do
      response = subject.serialize

      expect(response).to eq(expected_response)
    end
  end
end