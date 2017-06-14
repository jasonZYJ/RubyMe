#encoding: UTF-8
class Hash
  # for example we can use it to format controller params hash and nullify empty string then we can use ||= sign
  def blank_to_nulls!
    each { |k, v| self[k] = nil if v.blank? }
  end

  def deep_blank_to_nulls!
    each { |k, v| self[k] = nil if v.blank? }
    each { |k, v| v.deep_blank_to_nulls! if v.kind_of?(Hash) }
  end
end
