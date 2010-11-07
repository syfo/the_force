require 'the_force/ruby_version'

#CRZ - don't have test surface for changing RUBY_PATCHLEVEL and RUBY_VERSION inside TheForce
#      thus we rely on rvm rake test for completeness

class TestRubyVersion < Test::Unit::TestCase
  def setup
    @v = TheForce.ruby_version
  end

  def test_returns_numbers_not_strings
    assert [@v.major, @v.minor, @v.point, @v.patch].all? {|x| x.is_a? Integer}
  end

  def test_ruby_version_is_correct
    assert_equal RUBY_VERSION, [@v.major, @v.minor, @v.point].join('.')
  end
  
  def test_patchlevel_is_correct
    assert_equal RUBY_PATCHLEVEL, @v.patch
  end
  
  def test_tiny_and_patch_are_the_same
    assert_equal @v.tiny, @v.point
  end
  
  def test_is19?
    assert_equal [@v.major, @v.minor] == [1,9], @v.is19?
  end
    
  def test_is_frozen
    assert @v.frozen?
  end
end