require 'rails_helper'

describe Records::RecordService do
  describe 'class methods' do
    describe '.create' do
      let(:parsed_record) { 'some_parsed_record' }
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
  end
end