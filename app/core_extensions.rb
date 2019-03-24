module CoreExtensions
  module String
    def split_by_capitals
      self.split /(?=[A-Z])/
    end
  end
end
