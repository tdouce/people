require 'rails_helper'

describe MemoryDb do
  describe '.class methods' do
    describe '.reset' do
      let(:expected_response) { {records: []} }

      it 'sets the global variable to the initial state' do
        $memory_db[:something] = 'something'

        described_class.reset

        expect($memory_db).to eq(expected_response)
      end
    end

    describe '.add_record' do
      let(:record) { 'some_record' }
      let(:expected_response) do
        { records: [record] }
      end

      it 'add a record to the global variable' do
        described_class.add_record(record: record)

        expect($memory_db).to eq(expected_response)
      end
    end
  end
end