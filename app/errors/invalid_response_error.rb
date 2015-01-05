class InvalidResponseError < StandardError
  attr_reader :original_exception

  def initialize(e = nil)
    return super unless e

    super(e.raw.try(:[], :body) || e.raw)
    @original_exception = e
    set_backtrace e.backtrace
  end
end
