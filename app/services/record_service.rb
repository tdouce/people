class RecordService
  class ArraySort
    def initialize(records:, sort_orders:)
      @records = records
      @sort_orders = sort_orders
    end

    def sort
      records.sort do |a, b|
        comp = compare(a, b, sort_orders)
        comp
      end
    end

    private

    attr_reader :records, :sort_orders

    def compare(a, b, sort_orders)
      sort_order, *rest_sort_orders = sort_orders

      attr, order = sort_order

      comp = if order == 'asc'
               a.send(attr) <=> b.send(attr)
             elsif order == 'desc'
               b.send(attr) <=> a.send(attr)
             else
               raise 'unknown sort order'
             end

      if comp.zero?
        comp = if rest_sort_orders.length == 0
                 comp
               else
                 compare(a, b, rest_sort_orders)
               end
      end

      comp
    end
  end

  Record = Struct.new(
    :last_name,
    :first_name,
    :gender,
    :favorite_color,
    :date_of_birth,
    keyword_init: true
  )

  def self.create(record_params:)
    record = Record.new(record_params)

    $db[:records] << record

    record
  end

  def self.compare3(a, b, sort_orders)
    sort_order, *rest_sort_orders = sort_orders

    attr, order = sort_order

    comp = if order == 'asc'
             a.send(attr) <=> b.send(attr)
           elsif order == 'desc'
             b.send(attr) <=> a.send(attr)
           else
             raise 'unknown sort order'
           end

    if comp.zero?
      comp = if rest_sort_orders.length == 0
               comp
             else
               compare3(a, b, rest_sort_orders)
             end
    end

    comp
  end


  def self.sort(records:, sort_orders: [])
    ArraySort.new(records: records, sort_orders: sort_orders).sort

    # records.sort do |a, b|
    #   comp = compare3(a, b, sort_orders)
    #   comp
    # end
  end
end