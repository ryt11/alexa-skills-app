class RequestInteractor

  class Abstract
  def initialize(object)
    @object = object
  end

  def method_missing(method, *arguments)
    result = @object.send(method, *arguments)

    after() unless method == "has_valid_params"

    result
  end

  def after
    # whatever
  end
end

end
