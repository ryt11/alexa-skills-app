class BaseService

  attr_reader :request_interactor

  def initialize(&block)
    @request_interactor = RequestInteractor.new
  end

  def parse(response)
    JSON.parse(response)
  end

  def send!(verb, uri)
    Faraday.send(verb, uri)
  end
end
