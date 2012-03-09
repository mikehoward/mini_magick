require 'test_helper'

class CommandBuilderTest < Test::Unit::TestCase
  include MiniMagick

  def test_basic
    c = CommandBuilder.new("test")
    c.resize "30x40"
    assert_equal "-resize \"30x40\"", c.args.join(" ")
  end

  def test_complicated
    c = CommandBuilder.new("test")
    c.resize "30x40"
    c.alpha "1 3 4"
    c.resize "mome fingo"
    assert_equal "-resize \"30x40\" -alpha \"1 3 4\" -resize \"mome fingo\"", c.args.join(" ")
  end

  def test_plus_modifier_and_multiple_options
    c = CommandBuilder.new("test")
    c.distort.+ 'srt', '0.6 20'
    assert_equal "+distort \"srt\" \"0.6 20\"", c.args.join(" ")
  end
  
  def test_valid_command
    begin
      c = CommandBuilder.new("test", "path")
      c.input 2
      assert false
    rescue NoMethodError
      assert true
    end
  end

  def test_dashed
    c = CommandBuilder.new("test")
    c.auto_orient
    assert_equal "-auto-orient", c.args.join(" ")
  end
  
  # see http://www.imagemagick.org/Usage/basics/#option_ops for image creation operators
  # canvas caption gradient label logo pattern plasma radial radient rose text tile xc
  def test_canvas
    c = CommandBuilder.new('test')
    c.canvas 'black'
    assert_equal "canvas:black", c.args.join
  end
  
  def test_gradient
    c = CommandBuilder.new('test')
    c.gradient 'red-green'
    assert_equal 'gradient:red-green', c.args.join
  end

  def TEST_Logo
     c = CommandBuilder.new('test')
     c.logo
     assert_equal "logo:", c.args.join
   end
  
   def test_pattern
     c = CommandBuilder.new('test')
     c.pattern "checkerboard"
     assert_equal "pattern:checkerboard", c.args.join
   end
  
   def test_plasma
     c = CommandBuilder.new('test')
     c.plasma
     assert_equal "plasma:", c.args.join
   end
   
   def test_radial_gradient
     c = CommandBuilder.new('test')
     c.radial_gradient 'red-green'
     assert_equal "radial-gradient:red-green", c.args.join
   end
   
   def test_rose
     c = CommandBuilder.new('test')
     c.rose
     assert_equal "rose:", c.args.join
   end
   
   def test_text
     c = CommandBuilder.new('test')
     c.text "some text"
     assert_equal "text:'some text'", c.args.join
   end
   
   def test_xc
     c = CommandBuilder.new('test')
     c.xc 'gray'
     assert_equal "xc:gray", c.args.join
   end
 end
