require 'rails_helper'

describe RecordService do
  context 'class_methods' do
    describe '.sort' do
      it 'sorts by gender and then last_name' do
        record_1 = OpenStruct.new(gender: 'female', last_name: 'W', id: 1)
        record_2 = OpenStruct.new(gender: 'male',   last_name: 'U', id: 2)
        record_3 = OpenStruct.new(gender: 'female', last_name: 'A', id: 3)
        record_4 = OpenStruct.new(gender: 'male',   last_name: 'B', id: 4)
        record_5 = OpenStruct.new(gender: 'female', last_name: 'A', id: 0)

        records = [
          record_1,
          record_2,
          record_3,
          record_4,
          record_5
        ]

        response = described_class.sort(
          records: records,
          sort_orders: [['gender', 'asc'], ['last_name', 'asc'], ['id', 'asc']]
        )

        expect(response).to eq(
                              [
                                record_5,
                                record_3,
                                record_1,
                                record_4,
                                record_2
                              ]
                            )
      end
    end
  end
end