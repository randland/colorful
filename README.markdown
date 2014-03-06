# Background

Colorful is a gem that provides color and effect support to native Ruby Strings when printed in an ANSI color supporting terminal.

# Getting Started

Either `gem install colorful` or add `gem 'colorful'` to your `Gemfile` if you're using bundler.

# Usage

The following code will print "Test" in red using the terminal's color scheme:

    puts "Test".red

Background colors are also supported:

    puts "Test".blue_background

You can combine the two:

    puts "Test".red.blue_background

or:

    puts "Test".red_on_blue

Add some effects:

    puts "Test".red_on_blue.blink.underline

And then remove some:

    puts "Test".red_on_blue.blink.underline.no_blink

The supported terminal colors are:

*  black
*  red
*  green
*  yellow
*  blue
*  magenta
*  cyan
*  white
*  default

The supported effects are:
*  reset
*  bright/bold
*  italic
*  underline
*  blink
*  inverse
*  hide

Note that not all of these formats may not be supported in all environments.  Using an unsupported effect will not cause any display issues, other than the style not being applied.

Additionally, Colorful supports full rgb256 or HTML color values

To use rgb256 true red as the foreground:

    puts "Test".color(255, 0, 0)

For the HTML version:

    puts "Test".color("F00")

or:

    puts "Test".color("#ff0000")

or:

    puts "Test".color(:_ff0000)

These methods handle standard or shortened HTML codes, case insensitive, with or without # or _

Note that these methods require xterm 256 color support, and colors will be translated to the nearest possible valid color.

Lastly, some methods have been added that allow for cursor movement.  The supported movement operations include:
*  and_go_up(n)
*  and_go_down(n)
*  and_go_left(n)
*  and_go_right(n)
*  and_go_to(n)

To return to the beginning of the line:

    10.times do |n|
      print n.to_s.and_go_to 0
    end

or:

    10.times do |n|
      puts n.to_s.and_go_up 1
    end

Note that some methods work better with puts, and others with print.  Puts will implicitly add a new line to the end of the string it is printing, moving the cursor.

This is a work in progress but is stable.  Let me know if you would like a feature added to the project.
