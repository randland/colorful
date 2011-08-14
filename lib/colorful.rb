require "colorful/version"

module Colorful
  COLORS = { :black   => 0,
             :red     => 1,
             :green   => 2,
             :yellow  => 3,
             :blue    => 4,
             :magenta => 5,
             :cyan    => 6,
             :white   => 7,
             :default => 9 }

  EFFECTS = { :reset     => 0,
              :bright    => 1,
              :bold      => 1,
              :italic    => 3,
              :underline => 4,
              :blink     => 5,
              :inverse   => 7,
              :hide      => 8 }
end

class String
  Colorful::COLORS.each do |color, code|
    define_method color do
      inject_ansi_code 30 + code
    end

    define_method "#{color}_background" do
      inject_ansi_code 40 + code
    end

    Colorful::COLORS.each do |bg_color, bg_code|
      define_method "#{color}_on_#{bg_color}" do
        inject_ansi_code 30 + code, 40 + bg_code
      end
    end
  end

  Colorful::EFFECTS.each do |effect, code|
    define_method effect do
      inject_ansi_code code
    end

    define_method "no_#{effect}" do
      inject_ansi_code 20 + code
    end
  end

  private
  def inject_ansi_code *codes
    result = self
    codes.each do |code|
      if result =~ /^\e\[[0-9;]*m/
        terminator = result.index('m')
        result = result.insert(terminator, ";#{code}")
      else
        result = "\e[#{code}m#{result}\e[m"
      end
    end
    result
  end
end
