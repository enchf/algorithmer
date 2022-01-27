# frozen_string_literal: true

# Utility mixin.
module Utils
  TABLE_LENGTH = 120
  TABLE_STYLE = { width: TABLE_LENGTH }.freeze

  def to_camelcase(str)
    str.chars.slice_before { |ch| /[A-Z]/.match?(ch) }.map(&:join).map(&:downcase).join('_')
  end

  def ensure_present(config, property, object)
    raise "Missing config property #{property} in #{object}" unless config.key?(property)
  end

  def single_cell_matrix(value, width = TABLE_LENGTH)
    build_table([[value]], style: { width: width })
  end

  def build_table(rows, title: nil, headers: nil, style: TABLE_STYLE)
    config = { rows: rows, title: title, style: style }
    config[:headings] = headers unless headers.nil?
    Terminal::Table.new(config).to_s
  end

  def print_banner(text, font = 'rectangles')
    puts "\n#{Artii::Base.new(font: font).asciify(text)}"
    puts "\n"
  end
end
