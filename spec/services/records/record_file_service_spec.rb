require 'rails_helper'

describe Records::RecordFileService do
  context 'class methods' do
    describe '.parse_files' do
      let(:file_path_1) { 'some_file_path_1' }
      let(:file_path_2) { 'some_file_path_2' }
      let(:file_paths) { [file_path_1, file_path_2] }
      let(:record_file_service_klass) { class_double(described_class) }
      let(:parsed_record_1) { 'some_parsed_record_1' }
      let(:parsed_record_2) { 'some_parsed_record_2' }
      let(:parsed_records_1) { [parsed_record_1] }
      let(:parsed_records_2) { [parsed_record_2] }
      let(:expected_response) do
        [
          parsed_record_1,
          parsed_record_2
        ]
      end

      it 'parses multiple record files' do
        expect(record_file_service_klass).to receive(:parse_file).with(
          file_path: file_path_1
        ).and_return(parsed_records_1)

        expect(record_file_service_klass).to receive(:parse_file).with(
          file_path: file_path_2
        ).and_return(parsed_records_2)

        response = described_class.parse_files(
          file_paths: file_paths,
          record_file_service_klass: record_file_service_klass
        )

        expect(response).to eq(expected_response)
      end
    end

    describe '.parse_file' do
      let(:file_path) { 'some_file_path' }
      let(:file_klass) { class_double(File) }
      let(:record_parsing_service_klass) { class_double(Records::RecordParsingService) }
      let(:record_parsing_service) { instance_double(Records::RecordParsingService) }
      let(:record_klass) { class_double(Record) }
      let(:record_1) { instance_double(Record) }
      let(:record_2) { instance_double(Record) }
      let(:record_string_1) { "some_read_file_contents_1" }
      let(:record_string_2) { "some_read_file_contents_2" }
      let(:read_file) { "#{ record_string_1 }\n#{ record_string_2 }" }
      let(:parsed_record_1) { generate_parsed_record }
      let(:parsed_record_2) { generate_parsed_record }
      let(:expected_response) do
        [
          record_1,
          record_2
        ]
      end

      it 'parses a record file' do
        expect(file_klass).to receive(:read).with(file_path).and_return(read_file)

        expect(record_parsing_service_klass).to receive(:new).with(
          record_string: record_string_1
        ).and_return(record_parsing_service)
        expect(record_parsing_service).to receive(:parse).and_return(parsed_record_1)

        expect(record_klass).to receive(:new).with(parsed_record_1).and_return(record_1)

        expect(record_parsing_service_klass).to receive(:new).with(
          record_string: record_string_2
        ).and_return(record_parsing_service)
        expect(record_parsing_service).to receive(:parse).and_return(parsed_record_2)

        expect(record_klass).to receive(:new).with(parsed_record_2).and_return(record_2)

        response = described_class.parse_file(
          file_path: file_path,
          file_klass: file_klass,
          record_parsing_service_klass: record_parsing_service_klass,
          record_klass: record_klass
        )

        expect(response).to eq(expected_response)
      end
    end
  end
end