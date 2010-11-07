require 'the_force/keep_trying'

class TestKeepTrying < Test::Unit::TestCase
  def test_defaults_to_three_tries
    assert_raise TestKeepTryingSpecialError do
      TheForce.keep_trying do |try|
        @try = try
        raise TestKeepTryingSpecialError
      end
    end
    
    assert_equal 3, @try
  end
  
  def test_will_throw_after_one_thousand_tries
    assert_raise TestKeepTryingSpecialError do
      TheForce.keep_trying(:times => 1000) do
        raise TestKeepTryingSpecialError
      end
    end
  end
  
  def test_will_throw_after_specific_number_of_tries
    succeeded = false
    
    begin
      TheForce.keep_trying(:times => 5) do |try|
        raise StandardError, "try ##{try}"
        succeeded = true
      end
    rescue StandardError => e
      assert_equal "try #5", e.message
    end
    
    assert_not_equal true, succeeded
  end
  
  include TheForce
  def test_keep_trying_is_a_module_function
    assert self.respond_to?(:keep_trying, true)
    assert !self.respond_to?(:keep_trying, false)
    assert_respond_to TheForce, :keep_trying
  end
  
  #def test_works_without_systemtimer
  #def test_works_with_systemtimer
  
  def test_systemtimer_is_not_loaded_in_19
    assert false, "PENDING"
  end
end

class TestKeepTryingSpecialError < StandardError
end