require 'spec_helper'

describe Graphic do
  before(:each) do
    @drawing = Drawing.new
    @graphics = @drawing.graphics
  end

  it 'should increment the z value' do
    g1 = @graphics.add(123, 2, '{ "sup": 2 }')
    g2 = @graphics.add(123, 3, '{ "cihll": 4 }')
    g3 = @graphics.add(123, 3, '{ "cihll": 4 }')
    g1.z.should == g3.z - 2
  end

  it 'should increment the z value even if delete' do
    g1 = @graphics.add(123, 2, '{ "sup": 2 }')
    g2 = @graphics.add(123, 3, '{ "cihll": 4 }')
    g2.destroy
    g3 = @graphics.add(123, 3, '{ "cihll": 4 }')
    g1.z.should == g3.z - 1
  end

  it 'should not change z value on modify' do
    g1 = @graphics.add(123, 2, '{ "sup": 2 }')
    oz = g1.z
    g1.modify('{ "sup": 3 }', nil);
    g1.z.should == oz
  end
end
