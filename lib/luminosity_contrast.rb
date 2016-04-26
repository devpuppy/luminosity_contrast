require "luminosity_contrast/version"

module LuminosityContrast

  class << self
    def relative_luminance(r,g,b)
      (0.2126 * f(r)) + (0.7152 * f(g)) + (0.0722 * f(b))
    end

    private def f(component)
      c = component / 255.0
      c <= 0.03928 ? c : ((c + 0.055) / 1.055) ** 2.4
    end
  end
end

