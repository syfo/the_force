require 'test/unit'
require 'active_record'
require 'delimited_attribute'

class Delimited < ActiveRecord::Base
  attr_delimited :need_a_fixture_or_sqlite_maybe_to_test
end

class TestDelimitedAttribute
  def setup; end
  def teardown; end
end