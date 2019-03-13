class String
  def self.constantize(string)
    Kernel.const_get(skill_module) if Kernel.const_defined?(skill_module)
  end
end
