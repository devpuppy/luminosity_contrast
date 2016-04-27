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

    # @param args a representation of an RGB color
    # @see .rgb_from
    def initialize(*args)
      input = args.size == 1 ? args[0] : args
      @r, @g, @b = Color.rgb_from(input)
    end

    # @return [Float] between 0.0 and 1.0
    # @see LuminosityContrast.relative_luminance
    def relative_luminance
      LuminosityContrast.relative_luminance(r,g,b)
    end

    # @param color [Color] a second color contrasting with this one
    # @return [Float] a ratio between 1.0 and 21.0
    # @see LuminosityContrast.ratio
    def ratio(color)
      LuminosityContrast.ratio(self, color)
    end

    # @return [Array] red, green, blue color components from 0.0 to 255.0
    def to_rgb
      [r, g, b]
    end

    class << self
      # Convert one of several RGB formats to an Array of components
      # @return [Array] red, green, blue color components from 0.0 to 255.0
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
      def rgb_from(input)
        case input
        when String # hex code
          raise 'Invalid hex code' unless input =~ /\A([0-9a-f]{3}){1,2}\z/i
          rgb = if input.size == 3
            input.split('').map { |h| h * 2 }
          else
            input.scan(/.{2}/)
          end
          rgb.map { |h| h.hex.to_i }
        when Array # array of numbers
          raise 'Invalid RGB array' unless input.size == 3
          input.map(&:to_f)
        when Hash
          rgb = input.values_at(:r, :g, :b)
          raise 'Invalid RGB hash' unless rgb.size == 3
          rgb.map(&:to_f)
        else
          methods = [:r,:g, :b]
          if methods.select { |m| input.respond_to?(m) }.size == methods.size
            methods.map { |m| input.send(m) }
          else
            raise 'Invalid input'
          end
        end
      end

    end
  end
end
