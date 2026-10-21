require 'test_helper'

class LuminosityContrastTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::LuminosityContrast::VERSION
  end

  def test_relative_luminance_of_black
    assert_equal 0.0, LuminosityContrast.relative_luminance(0, 0, 0)
  end

  def test_relative_luminance_of_white
    assert_in_delta 1.0, LuminosityContrast.relative_luminance(255, 255, 255), 1e-12
  end

  def test_ratio_of_black_and_white
    assert_in_delta 21.0, LuminosityContrast.ratio([0, 0, 0], [255, 255, 255]), 1e-12
  end

  def test_srgb_low_intensity_linearization
    expected = (0.2126 * (10.0 / 255.0 / 12.92))
    assert_in_delta expected, LuminosityContrast.relative_luminance(10, 0, 0), 1e-12
  end

  def test_srgb_high_intensity_linearization
    expected = 0.2126 * (((11.0 / 255.0 + 0.055) / 1.055) ** 2.4)
    assert_in_delta expected, LuminosityContrast.relative_luminance(11, 0, 0), 1e-12
  end

  def test_srgb_threshold_boundary
    threshold = 0.04045 * 255.0
    [threshold - 0.0001, threshold, threshold + 0.0001].each do |component|
      normalized = component / 255.0
      linear = normalized <= 0.04045 ? normalized / 12.92 : ((normalized + 0.055) / 1.055) ** 2.4
      assert_in_delta 0.2126 * linear, LuminosityContrast.relative_luminance(component, 0, 0), 1e-12
    end
  end

  def test_known_wcag_contrast_ratio
    assert_in_delta 4.478089453577214, LuminosityContrast.ratio('777777', 'ffffff'), 1e-10
  end

  def test_intermediate_gray
    expected = ((128.0 / 255.0 + 0.055) / 1.055) ** 2.4
    assert_in_delta expected, LuminosityContrast.relative_luminance(128, 128, 128), 1e-12
  end

  def test_ratio_is_symmetric_and_identical_colors_have_ratio_one
    assert_in_delta 1.0, LuminosityContrast.ratio('abc', 'abc'), 1e-12
    assert_in_delta LuminosityContrast.ratio('123456', 'abcdef'),
                    LuminosityContrast.ratio('abcdef', '123456'), 1e-12
  end

  def test_invalid_relative_luminance_components
    assert_raises(ArgumentError) { LuminosityContrast.relative_luminance(-1, 0, 0) }
    assert_raises(ArgumentError) { LuminosityContrast.relative_luminance(256, 0, 0) }
  end
end
