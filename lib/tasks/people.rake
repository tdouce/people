require 'csv'

namespace :files do
  desc 'Read in records from these files and combine them into a single set of records. Results are displayed in stdout'

  task :aggregate_records, [:file_1, :file_2, :file_3] => :environment do |_, args|
    file_1 = args.fetch(:file_1).strip
    file_2 = args.fetch(:file_2).strip
    file_3 = args.fetch(:file_3).strip

    records = RecordFileService.parse_files(files: [file_1, file_2, file_3])

    puts "--- sorted by gender (females before males) then by last name ascending ---"

    sorted_records_by_gender_by_last_name = RecordService.sort(
      records: records,
      sort_orders: [['gender', 'asc'], ['last_name', 'asc']]
    )

    serialized_records_by_gender_by_last_name = sorted_records_by_gender_by_last_name.map do |record|
      RecordSerializer.new(record).serialize
    end

    pp serialized_records_by_gender_by_last_name
  end
end
