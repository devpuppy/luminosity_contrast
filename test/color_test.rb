require 'test_helper'
require 'luminosity_contrast/color'

class ColorTest < Minitest::Test
  def test_color_from_hex_string_6
    assert_blue(LuminosityContrast::Color.new('0000ff'))
  end

  def test_color_from_hex_string_3
    assert_blue(LuminosityContrast::Color.new('00f'))
  end

  def test_color_from_array
    assert_blue(LuminosityContrast::Color.new([0, 0, 255]))
  end

  def test_color_from_hash
    assert_blue(LuminosityContrast::Color.new({b: 255, g: 0, r: 0}))
  end

  def test_color_from_positional_args
    assert_blue(LuminosityContrast::Color.new(0, 0, 255))
  end

  def test_color_from_kwargs
    assert_blue(LuminosityContrast::Color.new(r: 0, g: 0, b: 255))
  end

  def test_color_from_struct
    my_color = Struct.new(:r, :g, :b).new(0, 0, 255)
    assert_blue(LuminosityContrast::Color.new(my_color))
  end

  def test_color_from_color
    assert_blue(LuminosityContrast::Color.new(LuminosityContrast::Color.new(0, 0, 255)))
  end

  def test_color_compare
    black = LuminosityContrast::Color.new('000')
    white = LuminosityContrast::Color.new('fff')
    assert_in_delta 21.0, black.ratio(white), 1e-12
    assert_in_delta 21.0, white.ratio(black), 1e-12
  end

  def test_invalid_hex
    ['#fff', 'zzzzzz', '1234', ''].each do |value|
      assert_raises(ArgumentError) { LuminosityContrast::Color.new(value) }
    end
  end

  def test_invalid_array_size
    assert_raises(ArgumentError) { LuminosityContrast::Color.new([0, 0]) }
  end

  def test_missing_hash_key
    assert_raises(ArgumentError) { LuminosityContrast::Color.new(r: 0, g: 0) }
  end

  def test_invalid_component_values
    [-1, 256, 'banana', nil, Float::NAN, Float::INFINITY].each do |value|
      assert_raises(ArgumentError) { LuminosityContrast::Color.new([value, 0, 0]) }
    end
  end

  def test_complex_components_are_rejected
    assert_raises(ArgumentError) { LuminosityContrast::Color.new([Complex(1, 2), 0, 0]) }
  end

  def test_rational_components_are_supported
    assert_equal [12.5, 20.0, 30.0], LuminosityContrast::Color.new(Rational(25, 2), 20, 30).to_rgb
  end

  def test_rgb_component_boundaries
    assert_equal [0.0, 255.0, 0.0], LuminosityContrast::Color.new(0, 255, 0).to_rgb
    assert_raises(ArgumentError) { LuminosityContrast::Color.new(0, 255.001, 0) }
  end

  def test_fractional_components_are_supported
    assert_equal [12.5, 20.0, 30.0], LuminosityContrast::Color.new(12.5, 20, 30).to_rgb
  end

  def assert_blue(color)
    assert_equal [0.0, 0.0, 255.0], color.to_rgb, "Color is not blue: #{color.to_rgb}"
  end
end
