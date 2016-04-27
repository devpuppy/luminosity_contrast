module LuminosityContrast
  class Color
    attr_reader :r, :g, :b

    def initialize(*args)
      input = args.size == 1 ? args[0] : args
      @r, @g, @b = Color.rgb_from(input)
    end

    def relative_luminance
      LuminosityContrast.relative_luminance(r,g,b)
    end

    def ratio(color)
      LuminosityContrast.ratio(self, color)
    end

    def to_rgb
      [r, g, b]
    end

    class << self

      # expects a 3 or 6 character hex color code
      # or an array with 3 numbers between 0 and 255
      # or an object that responds to .r, .g, .b
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
