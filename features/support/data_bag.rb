class DataBag < Hash
  class << self
    def reset_bag
      @bag = nil
    end

    [:order, :printing].each do |name|
      define_method :"#{name}=" do |value|
        bag[name] = value
      end

      define_method name do
        bag[name]
      end
    end

    private
    def bag
      @bag ||= DataBag.new
    end
  end
end

After do
  DataBag.reset_bag
end
