class Printer
  class << self
    def print(pdf_file)
      `lpr #{pdf_file} -P #{ServicesSettings.printer}`
    end
  end
end
