require 'test/unit'

class TestMappingArray < Test::Unit::TestCase
  def setup
    ###CRZ for some reason I have to include here or other tests interfere with it?
    require 'mapping_array'
  end

  def test_can_be_invoked_from_tilde
    assert_equal TheForce::MappingArray, (~[1]).class
  end
  
  def test_can_be_invoked_from_plus
    assert_equal TheForce::MappingArray, (+[1]).class
  end
  
  def test_can_be_invoked_from_method
    assert_equal TheForce::MappingArray, [1].to_ma.class
  end
  
  def test_tilde_doesnt_keep_mapping
    assert_equal Array, (~[1]*2).class
  end

  def test_plus_keeps_mapping
    assert_equal TheForce::MappingArray, (+[1]*2).class
  end

  def test_method_can_continuosly_map_or_not
    assert_equal Array, ([1].to_ma(false)*2).class
    assert_equal TheForce::MappingArray, ([1].to_ma(true)*2).class
  end
  
  def test_method_defaults_to_non_continous_map
    assert_equal Array, ([1].to_ma*2).class
  end
  
  def test_can_convert_back_to_normal_array
    assert_equal [1], [1].to_ma.to_a
  end
  
  def test_responds_to_to_ma
    assert_equal [1], [1].to_ma.to_ma.to_a
  end

  def test_unary_operator_maps
    assert_equal([1, 2], +([1, 2].to_ma(false)))
  end

  def test_binary_operator_maps
    assert_equal [16, 25], [4,5].to_ma ** 2
  end
  
  def test_method_maps
    assert_equal [16, 25], [4,5].to_ma.power!(2)
  end
  
  def test_chaining
    assert_equal [1, 2], [4,5].to_ma(true).*(2).-(8).+(2)./(2).to_a
  end
  
  def test_can_use_each
    output = []
    [1,2,3].each {|n| output << n }
    assert_equal [1,2,3], output
  end
end