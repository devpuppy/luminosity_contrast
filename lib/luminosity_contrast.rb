require "luminosity_contrast/version"
require "luminosity_contrast/color"

# Namespace for the gem. Contains methods to implement the Luminosity Contrast
# Ratio formula.
#
# This module is not designed to be included in a class.
module LuminosityContrast
  class << self
    # Calculate the Luminosity Contrast Ratio of two colors.
    # This method is the gem's _raison d'être_.
    #
    # @param rgb1 either of two colors to compare
    # @param rgb2 the other of two colors to compare
    # @example two RGB values as Arrays of three numbers
    #   LuminosityContrast.ratio([0, 0, 0], [255.0, 255.0, 255.0])
    # @example two hex code strings (3 or 6 characters)
    #   LuminosityContrast.ratio('000000', 'fff')
    # @example two LuminosityContrast::Color objects
    #   LuminosityContrast.ratio(color1, color2)
    # @return [Float] the Luminosity Contrast Ratio between 1.0 and 21.0
    def ratio(rgb1, rgb2)
      c1, c2 = [rgb1, rgb2].map { |rgb| Color.new(rgb) }
      l1, l2 = [c1, c2].map(&:relative_luminance).sort
      (l2 + 0.05) / (l1 + 0.05)
    end

    # @param r [Numeric] red component between 0.0 and 255.0
    # @param g [Numeric] green component between 0.0 and 255.0
    # @param b [Numeric] blue component between 0.0 and 255.0
    # @return [Float] relative luminance of a color between 0.0 and 1.0
    def relative_luminance(r, g, b)
      rgb = Color.rgb_from([r, g, b])
      (0.2126 * f(rgb[0])) + (0.7152 * f(rgb[1])) + (0.0722 * f(rgb[2]))
    end

    # assists calculation of relative luminance
    # @param component [Numeric] a single RGB component between 0.0 and 255.0
    # @return [Float] a value needed for relative luminance calculation
    private def f(component)
      c = component / 255.0
      c <= 0.04045 ? c / 12.92 : ((c + 0.055) / 1.055) ** 2.4
    end
  end
end
