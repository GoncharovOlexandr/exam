require 'minitest/autorun'
require_relative 'hash_json_converter'

class TestHashJsonConverter < Minitest::Test
  def setup
    @hash = { name: 'Alice', age: 30, languages: ['Ruby', 'Python'] }
    @json = '{"name":"Alice","age":30,"languages":["Ruby","Python"]}'
    @nested_hash = { user: { name: 'Bob', age: 25 }, languages: ['Ruby', 'JavaScript'] }
    @nested_json = '{"user":{"name":"Bob","age":25},"languages":["Ruby","JavaScript"]}'
  end

  def test_hash_to_json
    result = HashJsonConverter.hash_to_json(@hash)
    assert_equal @json, result
  end

  def test_json_to_hash
    result = HashJsonConverter.json_to_hash(@json)
    assert_equal @hash, result
  end

  def test_json_with_nested_hashes
    result = HashJsonConverter.json_to_hash(@nested_json)
    assert_equal @nested_hash, result
  end

  def test_hash_to_json_invalid_input
    assert_raises(ArgumentError) { HashJsonConverter.hash_to_json('not a hash') }
  end

  def test_json_to_hash_invalid_input
    assert_raises(ArgumentError) { HashJsonConverter.json_to_hash(12345) }
    assert_raises(JSON::ParserError) { HashJsonConverter.json_to_hash('invalid json') }
  end
end
