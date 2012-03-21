module StringExtensions
  def to_inquirer
    ActiveSupport::StringInquirer.new(self)
  end
end

String.send(:include, StringExtensions)
