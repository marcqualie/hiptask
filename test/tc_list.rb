$:.unshift File.expand_path(File.dirname(__FILE__) + "/../lib")

require "test/unit"
require "hiptask/list"

class TestList < Test::Unit::TestCase

    def test_add
        list = Hiptask::List.new("/dev/null")
        list.add("Test 1")
        puts list.items
        assert_equal(list.items, ["Test 1"])
    end

    def test_do
        list = Hiptask::List.new("/dev/null")
        list.add("Test 1")
        assert_equal(list.items, ["Test 1"])
        list.do("1")
        assert_equal(list.items, [">Test 1"])
    end

    def test_undo
        list = Hiptask::List.new("/dev/null")
        list.add("Test 1")
        assert_equal(list.items, ["Test 1"])
        list.do("1")
        assert_equal(list.items, [">Test 1"])
        list.undo("1")
        assert_equal(list.items, ["Test 1"])
    end

    def test_update
        list = Hiptask::List.new("/dev/null")
        list.add("Test 1")
        assert_equal(list.items, ["Test 1"])
        list.update("1", "Test 2")
        assert_equal(list.items, ["Test 2"])
        list.do("1")
        assert_equal(list.items, [">Test 2"])
        list.update("1", "Test 3")
        assert_equal(list.items, [">Test 3"])
    end

    def test_delete
        list = Hiptask::List.new("/dev/null")
        list.add("Test 1")
        assert_equal(list.items, ["Test 1"])
        list.delete("1")
        assert_equal(list.items, [])
    end

end
