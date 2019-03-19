class BaseService

  attr_reader :request_interactor

  def initialize(&block)
    @request_interactor = RequestInteractor.new
  end

  def parse(response)
    JSON.parse(response)
  end

  def self.http_request!()
    ss
  end
end
