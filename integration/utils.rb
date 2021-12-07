# frozen_string_literal: true

module Utils
  TABLE_LENGTH = 80
  TABLE_STYLE = { width: TABLE_LENGTH }

  def to_camelcase(str)
    str.chars.slice_before { |ch| /[A-Z]/.match?(ch) }.map(&:join).map(&:downcase).join('_')
  end

  def ensure_present(config, property, object)
    raise "Missing config property #{property} in #{object}" unless config.key?(property)
  end

  def single_cell_matrix(value, style = Utils::TABLE_STYLE)
    build_table([[value]])
  end

  def build_table(rows, style = Utils::TABLE_STYLE)
    Terminal::Table.new(rows: rows, style: style).to_s
  end

  def print_banner(text, font = 'roman')
    puts "\n" + Artii::Base.new(font:'roman').asciify(text)
    puts "\n"
  end
end
