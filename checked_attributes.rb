
module CheckedAttributes

  def attr_checked(klass, attr, &validation)

    klass.class_eval do
      # generate getter
      define_method attr do
        instance_variable_get "@#{attr}"
      end
      # generate setter
      define_method "#{attr}=" do |value|
        raise RuntimeError.new("Invalid value") unless validation.call(value)
        instance_variable_set("@#{attr}", value)
      end
    end
  end

end
