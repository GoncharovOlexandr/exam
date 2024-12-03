require 'json'

class HashJsonConverter
  # Перетворює хеш у JSON
  def self.hash_to_json(hash)
    raise ArgumentError, 'Input must be a hash' unless hash.is_a?(Hash)
    JSON.generate(hash)
  end

  # Перетворює JSON у хеш і конвертує ключі в символи рекурсивно
  def self.json_to_hash(json)
    raise ArgumentError, 'Input must be a valid JSON string' unless json.is_a?(String)
    begin
      deep_symbolize_keys(JSON.parse(json))
    rescue JSON::ParserError => e
      raise JSON::ParserError, "Invalid JSON format: #{e.message}"
    end
  end

  # Рекурсивно перетворює ключі в символи для вкладених хешів
  def self.deep_symbolize_keys(obj)
    case obj
    when Hash
      obj.each_with_object({}) do |(key, value), memo|
        memo[key.to_sym] = deep_symbolize_keys(value)
      end
    when Array
      obj.map { |element| deep_symbolize_keys(element) }
    else
      obj
    end
  end
end
