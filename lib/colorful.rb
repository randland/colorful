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

    Colorful::COLORS.each do |bg_color, bg_code|
      define_method "#{color}_on_#{bg_color}" do
        inject_ansi_code 30 + code, 40 + bg_code
      end
    end

    define_method "#{color}_background" do
      inject_ansi_code 40 + code
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

  def foreground(*args)
    code = ansi_color_code *args
    inject_ansi_code 38, 5, code
  end
  alias :fg :foreground
  alias :color :foreground
  alias :colour :foreground

  def background(*args)
    code = ansi_color_code *args
    inject_ansi_code 48, 5, code
  end
  alias :bg :background
  alias :on :background

private
  def ansi_color_code *args
    if args.size == 3
      ansi_rgb_color *args
    else
      str = args[0].to_s.sub(/^(#|_)/, '')
      if str.size == 3
        red, green, blue = str[0] * 2, str[1] * 2, str[2] * 2
      elsif str.size == 6
        red, green, blue = str[0,2], str[2,2], str[4,2]
      else
        raise 'Malformed color string'
      end
      ansi_rgb_color red.to_i(16), green.to_i(16), blue.to_i(16)
    end
  end

  def ansi_rgb_color *args
    red, green, blue = args
    args.inject('') do |m,c|
      m << (c / 256.0 * 6.0).to_i.to_s
    end.to_i(6) + 16
  end

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
