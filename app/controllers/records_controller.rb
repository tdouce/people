class RecordsController < ApplicationController
  def create
    record = params.require(:record)
    record_params = record.permit(
      :data
    )

    record_string = record_params.fetch(:data)
    record_parsing_service = RecordParsingService.new(record_string: record_string)
    record_params = record_parsing_service.to_h

    record = RecordService.create(
      record_params: record_params
    )

    serialized_record = RecordSerializer.new(record).serialize

    render(
      json: {
        record: serialized_record
      },
      status: :created
    )

  end
end
