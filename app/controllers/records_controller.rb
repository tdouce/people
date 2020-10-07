class RecordsController < ApplicationController
  def create
    record_params = params.permit(:record)
    record_string = record_params.fetch(:record)

    record_parsing_service = ::Records::RecordParsingService.new(record_string: record_string)
    parsed_record = record_parsing_service.parse

    record = ::Records::RecordService.create!(parsed_record: parsed_record)

    record_serializer = ::Records::Serializers::RecordSerializer.new(record)
    serialized_record = record_serializer.serialize

    render(
      json: {
        record: serialized_record
      },
      status: :created
    )
  end
end