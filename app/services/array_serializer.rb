class ArraySerializer
  def initialize(items:, serializer_klass:)
    @items = items
    @serializer_klass = serializer_klass
  end

  def serialize
    items.map do |item|
      serializer = serializer_klass.new(item)
      serializer.serialize
    end
  end

  private

  attr_reader :items, :serializer_klass
end