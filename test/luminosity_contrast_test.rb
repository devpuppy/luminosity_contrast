require 'test_helper'

class LuminosityContrastTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::LuminosityContrast::VERSION
  end

  def test_relative_luminance_of_black
    assert_equal 0.0, LuminosityContrast.relative_luminance(0,0,0)
  end

  def test_relative_luminance_of_white
    assert_equal 1.0, LuminosityContrast.relative_luminance(255,255,255)
  end

  def test_ratio_of_black_and_white
    assert_equal 21.0, LuminosityContrast.ratio([0,0,0], [255,255,255])
  end
end
