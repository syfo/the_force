require 'test/unit'
require 'keep_trying.rb'

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
  
  def self.include_the_force
    include TheForce
  end
  def test_keep_trying_is_a_module_function
    TestKeepTrying.include_the_force
    assert self.respond_to?(:keep_trying, true)
    assert !self.respond_to?(:keep_trying, false)
    assert_respond_to TheForce, :keep_trying
  end

  ###CRZ - these should be 2 separate contexts in which to run all tests.
  def test_load_timeout_when_systemtimer_not_present
    Object.send(:remove_const, :TheForce)
    Object.send(:remove_const, :SystemTimer) if defined? ::SystemTimer
    require 'timeout'
    load File.expand_path('../../../lib/the_force/keep_trying.rb', __FILE__) 
    
    assert_equal ::Timeout, TheForce.timeout_class
  end

  def test_load_systemtimer_when_present  
    Object.send(:remove_const, :TheForce)
    Object.send(:remove_const, :SystemTimer) if defined? ::SystemTimer
    require 'system_timer'
    load File.expand_path('../../../lib/the_force/keep_trying.rb', __FILE__) 

    assert_equal ::SystemTimer, TheForce.timeout_class  
  end
end

class TestKeepTryingSpecialError < StandardError
end