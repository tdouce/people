require 'rails_helper'

describe Records::RecordParsingService do
  let(:last_name) { 'Scio' }
  let(:first_name) { 'Amy' }
  let(:gender) { 'female' }
  let(:favorite_color) { 'red' }
  let(:date_of_birth) { '1985-11-02' }

  subject do
    described_class.new(record_string: record_string)
  end

  describe '#parse' do
    let(:expected_response) do
      {
        last_name: last_name,
        first_name: first_name,
        gender: gender,
        favorite_color: favorite_color,
        date_of_birth: date_of_birth
      }
    end

    context 'when the record string is comma delimited' do
      let(:record_string) do
        "#{ last_name },#{ first_name },#{ gender },#{ favorite_color},#{ date_of_birth }"
      end

      it 'returns a parsed record' do
        response = subject.parse

        expect(response).to eq(expected_response)
      end
    end

    context 'when the record string is pipe delimited' do
      let(:record_string) do
        "#{ last_name }|#{ first_name }|#{ gender }|#{ favorite_color}|#{ date_of_birth }"
      end

      it 'returns a parsed record' do
        response = subject.parse

        expect(response).to eq(expected_response)
      end
    end

    context 'when the record string is space delimited' do
      let(:record_string) do
        "#{ last_name } #{ first_name } #{ gender } #{ favorite_color} #{ date_of_birth }"
      end

      it 'returns a parsed record' do
        response = subject.parse

        expect(response).to eq(expected_response)
      end
    end
  end
end