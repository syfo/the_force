require 'the_force/slugs'

class TestSlugs < Test::Unit::TestCase
  def test_returns_original_slug_if_not_present_in_collection
    assert_equal 'a', TheForce.unique_slug('a', [])
  end
  
  def test_replaces_spaces_with_underscores
    assert_equal 'a_b', TheForce.unique_slug('a b', [])
  end
  
  def test_strips_before_changing
    assert_equal 'a_b', TheForce.unique_slug(' a b ', [])
  end

  def test_strips_before_comparing
    assert_equal 'a_b_2', TheForce.unique_slug(' a b ', ['a_b'])
  end

  def test_removes_non_alphanumerics
    assert_equal 'ab', TheForce.unique_slug('a\'b%', [])
  end
  
  def test_adds_numeric_suffix_of_2_if_present_in_collection
    assert_equal 'a_2', TheForce.unique_slug('a', ['a'])
  end

  def test_increments_numeric_suffix_until_not_present_in_collection
    assert_equal 'a_4', TheForce.unique_slug('a', ['a', 'a_1', 'a_2', 'a_3'])
  end
  
  def test_implicit_collect_column
    assert_equal false, "PENDING -- TheForce.unique_slug('super title', Gallery, :permalink)"
  end
end