require 'rails_helper'

describe Records::RecordSortingService do
  let(:records) do
    [
      record_1,
      record_2,
      record_3
    ]
  end

  subject do
    described_class.new(
      records: records
    )
  end

  describe '#sort_by_gender_by_last_name' do
    let(:record_1) { instance_double(Record, gender: 'male', last_name: 'a') }
    let(:record_2) { instance_double(Record, gender: 'male', last_name: 'z') }
    let(:record_3) { instance_double(Record, gender: 'female', last_name: 'a') }
    let(:record_4) { instance_double(Record, gender: 'female', last_name: 'z') }
    let(:records) do
      [
        record_1,
        record_2,
        record_3,
        record_4
      ]
    end
    let(:expected_response) do
      [
        record_4,
        record_3,
        record_2,
        record_1
      ]
    end

    it 'sorts records by gender ascending then by last_name descending' do
      response = subject.sort_by_gender_by_last_name

      expect(response).to eq(expected_response)
    end
  end

  describe '#sort_by_gender' do
    let(:record_1) { instance_double(Record, gender: 'male') }
    let(:record_2) { instance_double(Record, gender: 'male') }
    let(:record_3) { instance_double(Record, gender: 'female') }
    let(:expected_response) do
      [
        record_3,
        record_1,
        record_2
      ]
    end

    it 'sorts records by gender ascending' do
      response = subject.sort_by_gender

      expect(response).to eq(expected_response)
    end
  end

  describe '#sort_by_date_of_birth' do
    let(:record_1) { instance_double(Record, date_of_birth: Date.parse('2020/01/01')) }
    let(:record_2) { instance_double(Record, date_of_birth: Date.parse('2019/01/01')) }
    let(:record_3) { instance_double(Record, date_of_birth: Date.parse('2018/01/01')) }
    let(:expected_response) do
      [
        record_3,
        record_2,
        record_1
      ]
    end

    it 'sorts records by gender ascending' do
      response = subject.sort_by_date_of_birth

      expect(response).to eq(expected_response)
    end
  end

  describe '#sort_by_gender' do
    let(:record_1) { instance_double(Record, gender: 'male') }
    let(:record_2) { instance_double(Record, gender: 'male') }
    let(:record_3) { instance_double(Record, gender: 'female') }
    let(:expected_response) do
      [
        record_3,
        record_1,
        record_2
      ]
    end

    it 'sorts records by gender ascending' do
      response = subject.sort_by_gender

      expect(response).to eq(expected_response)
    end
  end

  describe '#sort_by_last_name' do
    let(:record_1) { instance_double(Record, last_name: 'Zippy') }
    let(:record_2) { instance_double(Record, last_name: 'Kip') }
    let(:record_3) { instance_double(Record, last_name: 'Adam') }
    let(:expected_response) do
      [
        record_3,
        record_2,
        record_1
      ]
    end

    it 'sorts records by gender ascending' do
      response = subject.sort_by_last_name

      expect(response).to eq(expected_response)
    end
  end
end