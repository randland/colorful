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

end
