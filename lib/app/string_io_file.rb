module App
  class StringIOFile < StringIO
    attr_accessor :original_filename

    def initialize(string, filename)
      super(string.is_a?(StringIO) ? string.read : string)
      @original_filename = filename
    end
  end
end
