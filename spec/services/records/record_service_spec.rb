require 'rails_helper'

describe Records::RecordService do
  describe 'class methods' do
    describe '.create' do
      let(:parsed_record) { generate_parsed_record }
      let(:database_klass) { class_double(MemoryDb) }
      let(:record_klass) { class_double(Record) }
      let(:record) { instance_double(Record) }

      it 'creates a record in the database' do
        expect(record_klass).to receive(:new).with(
          parsed_record
        ).and_return(record)

        expect(database_klass).to receive(:add_record).with(
          record: record
        ).and_return(record)

        response = described_class.create!(
          parsed_record: parsed_record,
          record_klass: record_klass,
          database_klass: database_klass
        )

        expect(response).to eq(record)
      end
    end

    describe '.find_records' do
      let(:database_klass) { class_double(MemoryDb) }
      let(:record_sorting_service_klass) { class_double(Records::RecordSortingService) }
      let(:record_sorting_service) { instance_double(Records::RecordSortingService) }
      let(:sorted_records) { expected_response }
      let(:expected_response) { 'some_sorted_records' }
      let(:all_records) { 'some_all_records' }

      subject(:response) do
        described_class.find_records(
          sort: sort,
          database_klass: database_klass,
          record_sorting_service_klass: record_sorting_service_klass
        )
      end

      before do
        expect(database_klass).to receive(:all_records).and_return(all_records)

        expect(record_sorting_service_klass).to receive(:new).with(
          records: all_records
        ).and_return(record_sorting_service)
      end

      context "when sort is 'gender'" do
        let(:sort) { 'gender' }

        it 'returns records sorted by gender' do
          expect(record_sorting_service).to receive(:sort_by_gender).and_return(sorted_records)

          expect(response).to eq(expected_response)
        end
      end

      context "when sort is 'birthdate'" do
        let(:sort) { 'birthdate' }

        it 'returns records sorted by date_of_birth' do
          expect(record_sorting_service).to receive(:sort_by_date_of_birth).and_return(sorted_records)

          expect(response).to eq(expected_response)
        end
      end

      context "when sort is 'name'" do
        let(:sort) { 'name' }

        it 'returns records sorted by last_name' do
          expect(record_sorting_service).to receive(:sort_by_last_name).and_return(sorted_records)

          expect(response).to eq(expected_response)
        end
      end

      context 'when sort is unrecognized' do
        let(:sort) { 'unrecognized' }

        it 'returns records sorted by gender' do
          expect(record_sorting_service).to receive(:sort_by_gender).and_return(sorted_records)

          expect(response).to eq(expected_response)
        end
      end
    end
  end
end