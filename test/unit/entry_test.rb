# coding: utf-8
require 'test_helper'

class EntryTest < ActiveSupport::TestCase
  test "factory_girl" do
    assert_not_nil Factory(:entry)
  end
end
