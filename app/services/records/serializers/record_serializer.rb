module Records
  module Serializers
    class RecordSerializer
      def initialize(record)
        @record = record
      end

      def serialize
        {
          last_name: record.last_name,
          first_name: record.first_name,
          gender: record.gender,
          favorite_color: record.favorite_color,
          date_of_birth: formatted_date_of_birth
        }
      end

      private

      attr_reader :record

      def formatted_date_of_birth
        date_of_birth = Date.parse(record.date_of_birth)
        date_of_birth.strftime('%m/%d/%Y')
      end
    end
  end
end