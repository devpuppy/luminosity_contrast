module LuminosityContrast

  # @!attribute [r] r
  #   @return [Float] the red component
  # @!attribute [r] g
  #   @return [Float] the green component
  # @!attribute [r] b
  #   @return [Float] the blue component
  #
  # Color object parses RGB formats like hex code string or array of numbers.
  # Populates RGB attributes and provides convenience methods for comparing
  # colors. This class is used by LuminosityContrast.ratio but can also be used
  # on its own.
  class Color

    attr_reader :r, :g, :b

    # @param args a color representation, or three RGB components
    # @see .rgb_from
    def initialize(*args)
      input = args.size == 1 ? args[0] : args
      @r, @g, @b = Color.rgb_from(input)
    end

    # @return [Float] between 0.0 and 1.0
    # @see LuminosityContrast.relative_luminance
    def relative_luminance
      LuminosityContrast.relative_luminance(r, g, b)
    end

    # @param color [Color, Array, Hash, String] a second color to compare
    # @return [Float] a ratio between 1.0 and 21.0
    # @see LuminosityContrast.ratio
    def ratio(color)
      LuminosityContrast.ratio(self, color)
    end

    # @return [Array<Float>] red, green, blue components from 0.0 to 255.0
    def to_rgb
      [r, g, b]
    end

    class << self
      # Convert one of several RGB formats to an Array of components
      # @return [Array<Float>] red, green, blue components from 0.0 to 255.0
      # @param input a representation of an RGB color
      # @example 3 or 6 character hex color code String
      #   rgb_from('fff')
      #   rgb_from('000000')
      # @example Array with 3 numbers between 0 and 255
      #   rgb_from([0, 127.0, 255])
      # @example a Hash with 3 numbers between 0 and 255
      #   rgb_from(r: 0, g: 127.0, b: 255)
      # @example an Object that responds to methods #r, #g, #b
      #   color = Color.new('000')
      #   rgb_from(color)
      # @raise [ArgumentError] if the input is malformed or a component is not a finite real number from 0 to 255
      def rgb_from(input)
        rgb = case input
        when String # hex code
          raise ArgumentError, 'Invalid hex code' unless /\A(?:[0-9a-f]{3}|[0-9a-f]{6})\z/i.match?(input)
          pairs = input.size == 3 ? input.chars.map { |h| h * 2 } : input.scan(/../)
          pairs.map { |h| h.to_i(16) }
        when Array # array of numbers
          raise ArgumentError, 'Invalid RGB array' unless input.size == 3
          input
        when Hash
          raise ArgumentError, 'Invalid RGB hash' unless [:r, :g, :b].all? { |key| input.key?(key) }
          input.values_at(:r, :g, :b)
        else
          raise ArgumentError, 'Invalid input' unless [:r, :g, :b].all? { |key| input.respond_to?(key) }
          [:r, :g, :b].map { |key| input.public_send(key) }
        end
        rgb.map do |component|
          unless (component.is_a?(Integer) || component.is_a?(Float) || component.is_a?(Rational)) &&
                 component.finite? && component >= 0 && component <= 255
            raise ArgumentError, 'RGB components must be finite numbers between 0 and 255'
          end
          component.to_f
        end
      end

    end
  end
end
