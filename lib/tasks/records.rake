require 'csv'

namespace :files do
  desc 'Read in records from these files and combine them into a single set of records. Results are displayed in stdout'

  task :aggregate_records, [:file_path_1, :file_path_2, :file_path_3] => :environment do |_, args|
    file_path_1 = args.fetch(:file_path_1).strip
    file_path_2 = args.fetch(:file_path_2).strip
    file_path_3 = args.fetch(:file_path_3).strip
    
    records = Records::RecordFileService.parse_files(
      file_paths: [file_path_1, file_path_2, file_path_3]
    )

    record_sorting_service = Records::RecordSortingService.new(records: records)

    puts "--- sorted by gender (females before males) then by last name ascending ---"

    records_sorted_by_gender_by_last_name = record_sorting_service.sort_by_gender_by_last_name
    serialized_by_gender_by_last_name = ArraySerializer.new(
      items: records_sorted_by_gender_by_last_name,
      serializer_klass: Records::Serializers::RecordSerializer
    ).serialize

    pp serialized_by_gender_by_last_name

    puts "--- sorted by birth date, ascending ---"

    records_sorted_by_date_of_birth = record_sorting_service.sort_by_date_of_birth

    serialized_by_date_of_birth = ArraySerializer.new(
      items: records_sorted_by_date_of_birth,
      serializer_klass: Records::Serializers::RecordSerializer
    ).serialize

    pp serialized_by_date_of_birth

    puts "--- sorted by last name, descending ---"

    records_sorted_by_last_name = record_sorting_service.sort_by_last_name(
      sort_direction: :desc
    )

    serialized_by_last_name = ArraySerializer.new(
      items: records_sorted_by_last_name,
      serializer_klass: Records::Serializers::RecordSerializer
    ).serialize

    pp serialized_by_last_name
  end
end