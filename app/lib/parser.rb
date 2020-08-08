# frozen_string_literal: true

class Parser
  def self.phone(val)
    numbers = numbers(val)

    pattern = numbers.length == 10 ? /(\d{1,2})(\d{4})(\d{4}$)/ : /(\d{1,2})(\d{5})(\d{4}$)/
    numbers.gsub!(pattern, "(\\1) \\2-\\3")
  end

  def self.cnpj(val)
    return "" if !val || val == 0 || val.to_s.empty?

    numbers = numbers(val).rjust(14, "0")
    pattern = /(\d{2})(\d{3})(\d{3})(\d{4})(\d{2})/
    numbers.gsub!(pattern, "\\1.\\2.\\3/\\4-\\5")
  end

  def self.cpf(val)
    return "" if !val || val == 0 || val.to_s.empty?

    numbers = numbers(val).rjust(11, "0")
    pattern = /(\d{3})(\d{3})(\d{3})(\d{2})/
    numbers.gsub!(pattern, "\\1.\\2.\\3-\\4")
  end

  def self.cpf_cnpj(val, type = nil)
    return "" if !val || val == 0 || val.to_s.empty?

    type ||= val.to_s.length > 11 ? :cnpj : :cpf
    type == :cnpj ? cnpj(val) : cpf(val)
  end

  def self.numbers(val)
    return "" unless val
    val.to_s.gsub(/\D/, "")
  end

  def self.decimal(val)
    return if val.blank?

    val = val.to_s

    if /\d+[,]\d{2}/.match?(val)
      BigDecimal(val.to_s.gsub(/\D/, "")) / 100
    elsif /\d+[,]\d{1}/.match?(val)
      BigDecimal(val.to_s.gsub(/\D/, "")) / 10
    else
      BigDecimal(val)
    end
  rescue
    val
  end

  def self.sanitize(val)
    val.encode("UTF-8", invalid: :replace, undef: :replace, replace: "")
  end

  def self.nil_to_zero(val)
    if val.is_a? Enumerable
      val.map { |v| nil_to_zero(v) }
    else
      val.presence || 0
    end
  end

  def self.auto_cast(val)
    case val
    when /^\d+$/
      Integer(val)
    when /^(?!-0$)[+-]?([1-9]\d*|0)(\.\d+)?$/
      BigDecimal(val)
    when "true", "false", "TRUE", "false"
      val.downcase === "true"
    else
      val
    end
  end
end
