require 'test_helper'
require 'luminosity_contrast/color'

class ColorTest < Minitest::Test
  def test_color_from_hex_string_6
    color = LuminosityContrast::Color.new('0000ff')
    assert_blue(color)
  end

  def test_color_from_hex_string_3
    color = LuminosityContrast::Color.new('00f')
    assert_blue(color)
  end

  def test_color_from_array
    color = LuminosityContrast::Color.new([0, 0, 255])
    assert_blue(color)
  end

  def test_color_from_hash
    color = LuminosityContrast::Color.new({b: 255, g: 0, r: 0})
    assert_blue(color)
  end

  def test_color_from_positional_args
    color = LuminosityContrast::Color.new(0, 0, 255)
    assert_blue(color)
  end

  def test_color_from_kwargs
    color = LuminosityContrast::Color.new(r: 0, g: 0, b: 255)
    assert_blue(color)
  end

  def test_color_from_struct
    Struct.new('MyColor', :r, :g, :b)
    my_color = Struct::MyColor.new(0, 0, 255)
    color = LuminosityContrast::Color.new(my_color)
    assert_blue(color)
  end

  def test_color_from_color
    original_color = LuminosityContrast::Color.new(0, 0, 255)
    color = LuminosityContrast::Color.new(original_color)
    assert_blue(color)
  end

  def assert_blue(color)
    assert_equal [0.0, 0.0, 255.0], color.to_rgb, "Color is not blue: #{color.to_rgb}"
  end

  def test_color_compare
    black = LuminosityContrast::Color.new('000')
    white = LuminosityContrast::Color.new('fff')
    assert_equal 21.0, black.ratio(white)
    assert_equal 21.0, white.ratio(black)
  end
end
