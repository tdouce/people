require 'rails_helper'

describe RecordsController do
  def response_body_to_hash(response)
    JSON.parse(response.body).deep_symbolize_keys
  end

  describe 'POST /records' do
    context 'success' do
      let(:record_parsing_service) { instance_double(Records::RecordParsingService) }
      let(:record_serializer) { instance_double(Records::Serializers::RecordSerializer) }
      let(:record_string) { 'some_record' }
      let(:params) do
        {
          record: record_string
        }
      end
      let(:serialized_record) { 'some_serialized_record' }
      let(:parsed_record) { 'some_parsed_record' }
      let(:record) { 'some_record' }
      let(:expected_response) do
        {
          record: serialized_record
        }
      end

      it 'creates a record' do
        expect(Records::RecordParsingService).to receive(:new).with(
          record_string: record_string
        ).and_return(record_parsing_service)

        expect(record_parsing_service).to receive(:parse).and_return(parsed_record)

        expect(Records::RecordService).to receive(:create!).with(
          parsed_record: parsed_record
        ).and_return(record)

        expect(Records::Serializers::RecordSerializer).to receive(:new).with(
          record
        ).and_return(record_serializer)

        expect(record_serializer).to receive(:serialize).and_return(serialized_record)

        post records_path, params: params

        expect(response_body_to_hash(response)).to eq(expected_response)
      end
    end
  end
end