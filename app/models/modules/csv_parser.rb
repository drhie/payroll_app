##
# This module provides behavior for parsing CSV data
module CsvParser
  require 'csv'

  def import(file)
    csv = CSV.parse(File.read(file), headers: true)
    OpenStruct.new({
      headers: headers(csv),
      rows: rows(csv),
      footer: footer(csv)
    })
  end

  private
  def attribute_hash(row)
    row.map { |data| [attr_key(data[0]), data[1]] }.to_h.symbolize_keys
  end

  def attr_key(key)
    key.strip.gsub(' ', '_')
  end

  def headers(csv)
    csv.headers.map { |header| attr_key(header) }
  end

  def rows(csv)
    csv.reject { |row| row.to_a.flatten.include?(nil) }
       .map    { |row| attribute_hash(row) }
  end

  def footer(csv)
    footer_row = csv.to_a.last.compact
    attribute_hash([footer_row])
  end
end
