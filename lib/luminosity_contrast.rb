require "luminosity_contrast/version"
require "luminosity_contrast/color"


module LuminosityContrast

  # module methods
  class << self
    # expects two RGB values as Arrays of three numbers
    # example: [0, 0, 0], [255.0, 255.0, 255.0]
    # returns the Luminosity Contrast Ratio between 1.0 and 21.0
    def ratio(rgb1, rgb2)
      c1, c2 = [rgb1, rgb2].map { |rgb| Color.new(rgb) }
      l1, l2 = [c1, c2].map(&:relative_luminance).sort
      (l2 + 0.05) / (l1 + 0.05)
    end

    # expects RGB as three numeric values between 0.0 and 255.0
    # returns relative luminance of a color between 0.0 and 1.0
    def relative_luminance(r, g, b)
      (0.2126 * f(r)) + (0.7152 * f(g)) + (0.0722 * f(b))
    end

    # assists calculation of relative luminance
    # expects a single RGB component between 0.0 and 255.0
    private def f(component)
      c = component / 255.0
      c <= 0.03928 ? c : ((c + 0.055) / 1.055) ** 2.4
    end
  end
end

