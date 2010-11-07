require 'the_force/object_support'

begin
  require 'active_support'
rescue LoadError
  puts "There are some special cases under Rails' active_support that we must test, please install the rails gem"
  raise
end

class TestObjectSupport < Test::Unit::TestCase
  def test_blank_slate_is_truly_blank
    assert_equal "a", "a".if.length
    assert_equal nil, "a".unless.length
  end
  
  def test_if_as_blank_slate_when_it_returns_true
    assert_equal "", "".if.empty?
  end
  def test_unless_as_blank_slate_when_it_returns_true
    assert_equal nil, "".unless.empty?
  end
    
  def test_if_as_blank_slate_when_it_returns_false
    assert_equal nil, "a".if.empty?
  end
  def test_unless_as_blank_slate_when_it_returns_false
    assert_equal "a", "a".unless.nil?
  end

  def test_if_as_blank_slate_when_it_returns_true_with_active_support_blank?
    assert_equal " ", " ".if.blank?
  end
  def test_unless_as_blank_slate_when_it_returns_true_with_active_support_blank?
    assert_equal nil, " ".unless.blank?
  end

  def test_if_as_blank_slate_when_it_returns_false_with_active_support_blank?
    assert_equal nil, "a".if.blank?
  end
  def test_unless_as_blank_slate_when_it_returns_false_with_active_support_blank?
    puts "here: " + "a".unless.blank?
    assert_equal "a", "a".unless.blank?
  end

  def test_if_with_block_when_it_returns_true
    assert_equal "", "".if {|x| x.empty? }
  end
  def test_unless_with_block_when_it_returns_true
    assert_equal nil, "".unless {|x| x.empty? }
  end

  
  def test_if_with_block_when_it_returns_false
    assert_equal nil, "a".if {|x| x.nil? }
  end
  def test_unless_with_block_when_it_returns_false
    assert_equal "a", "a".unless {|x| x.nil? }
  end


  def test_if_with_symbol_and_args_when_it_return_true
    assert_equal "a", "a".if(:eql?, "a")
  end
  def test_unless_with_symbol_and_args_when_it_return_true
    assert_equal nil, "a".unless(:eql?, "a")
  end
  
  
  def test_if_with_symbol_and_args_when_it_return_false
    assert_equal nil, "a".if(:eql?, "b")
  end  
  def test_unless_with_symbol_and_args_when_it_return_false
    assert_equal "a", "a".unless(:eql?, "b")
  end
end