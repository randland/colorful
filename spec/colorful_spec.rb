require 'spec_helper'

def color_codes
  { :black   => 0,
    :red     => 1,
    :green   => 2,
    :yellow  => 3,
    :blue    => 4,
    :magenta => 5,
    :cyan    => 6,
    :white   => 7,
    :default => 9 }
end

def effect_codes
  { :reset     => 0,
    :bright    => 1,
    :bold      => 1,
    :italic    => 3,
    :underline => 4,
    :blink     => 5,
    :inverse   => 7,
    :hide      => 8 }
end

describe String do
  let(:string) { "This is a test"}

  context 'colors' do
    color_codes.each do |color, code|

      describe "##{color}" do
        subject { string.send color }
        it { should == "\e[3#{code}m#{string}\e[m" }
      end

      describe "##{color}_background" do
        subject { string.send "#{color}_background" }
        it { should == "\e[4#{code}m#{string}\e[m" }
      end

      color_codes.each do |bg_color, bg_code|
        describe "##{color}_on_#{bg_color}" do
          subject { string.send "#{color}_on_#{bg_color}" }
          it { should == "\e[3#{code};4#{bg_code}m#{string}\e[m" }
        end

        describe "##{color}.#{bg_color}_background" do
          subject { string.send("#{color}").send("#{bg_color}_background") }
          it { should == "\e[3#{code};4#{bg_code}m#{string}\e[m" }
        end
      end
    end
  end

  context 'effects' do
    effect_codes.each do |effect, code|
      describe "##{effect}" do
        subject { string.send effect }
        it { should == "\e[#{code}m#{string}\e[m" }
      end

      describe "#no_#{effect}" do
        subject { string.send "no_#{effect}" }
        it { should == "\e[2#{code}m#{string}\e[m" }
      end
    end
  end
end
