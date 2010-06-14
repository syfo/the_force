require 'test/unit'
require 'memoize'

class Memoizer
  def initialize
    @value = 1
    @other = 2
  end
  
  def inc
    @value +=1
  end
  
  def meth
    3
  end
  
  attr_memoize :a do
    @value
  end
  
  attr_memoize :test_instance_variable_access do
    @other
  end
  
  attr_memoize :test_instance_method_access do
    meth
  end
end

class TestMemoize < Test::Unit::TestCase
  def setup
    @m = Memoizer.new
  end
  
  def test_raises_error_with_no_block
    assert_raise ArgumentError do
      Memoizer.class_eval('attr_memoize :b')
    end
  end

  def test_memoizes_first_time
    assert_equal 1, @m.a
  end

  def test_can_refer_to_instance_variables_inside_block
    assert_equal 2, @m.test_instance_variable_access
  end

  def test_can_call_instance_method_inside_block
    assert_equal 3, @m.test_instance_method_access    
  end
  
  def test_does_not_rememoize_second_time
    @m.a
    @m.inc
    assert_equal 1, @m.a
  end
  
  def test_memoizes_again_after_refresh
    @m.a
    @m.inc
    assert_equal 2, @m.a(true)
  end
end