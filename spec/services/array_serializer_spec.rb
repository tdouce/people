require 'rails_helper'

describe ArraySerializer do
  let(:item_1) { 'some_item_1' }
  let(:item_2) { 'some_item_2' }
  let(:items) do
    [
      item_1,
      item_2
    ]
  end
  let(:serializer_klass) { class_double(::Records::Serializers::RecordSerializer) }


  subject do
    described_class.new(
      items: items,
      serializer_klass: serializer_klass
    )
  end

  describe '#serialize' do
    let(:serializer) { instance_double(::Records::Serializers::RecordSerializer) }
    let(:serialized_item_1) { 'some_serialized_item_1' }
    let(:serialized_item_2) { 'some_serialized_item_2' }
    let(:expected_response) do
      [
        serialized_item_1,
        serialized_item_2
      ]
    end

    it 'serializes an array of items' do
      expect(serializer_klass).to receive(:new).with(
        item_1
      ).and_return(serializer)

      expect(serializer).to receive(:serialize).and_return(serialized_item_1)

      expect(serializer_klass).to receive(:new).with(
        item_2
      ).and_return(serializer)

      expect(serializer).to receive(:serialize).and_return(serialized_item_2)

      response = subject.serialize

      expect(response).to eq(expected_response)
    end
  end
end