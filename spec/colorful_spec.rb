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

    describe "#.ansi_rgb_color" do
      let(:r) { 0 }
      let(:g) { 0 }
      let(:b) { 0 }

      subject {string.send :ansi_rgb_color, r,g,b}

      context 'black' do
        it { should == 16 }
      end

      context 'red' do
        let(:r) { 255 }
        it { should == 196 }
      end

      context 'green' do
        let(:g) { 255 }
        it { should == 46 }
      end

      context 'blue' do
        let(:b) { 255 }
        it { should == 21 }
      end

      context 'white' do
      let(:r) { 255 }
      let(:g) { 255 }
      let(:b) { 255 }
        it { should == 231 }
      end
    end

    describe "#foreground" do
      context "RGB values" do
        context "black" do
          subject { string.foreground(0,0,0) }
          let(:code) { '16' }
          it { should == "\e[38;5;#{code}m#{string}\e[m" }
        end
        context "blue" do
          subject { string.foreground(0,0,255) }
          let(:code) { '21' }
          it { should == "\e[38;5;#{code}m#{string}\e[m" }
        end
        context "green" do
          subject { string.foreground(0,255,0) }
          let(:code) { '46' }
          it { should == "\e[38;5;#{code}m#{string}\e[m" }
        end
        context "red" do
          subject { string.foreground(255,0,0) }
          let(:code) { '196' }
          it { should == "\e[38;5;#{code}m#{string}\e[m" }
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
