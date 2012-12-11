require 'spec_helper'

describe Drawing do
  let(:drawing) { Drawing.new(slug: 'whatever', user: stub_model(User)) }

  it 'is invalid with no slug' do
    drawing.slug = nil
    drawing.should_not be_valid
  end

  it 'is invalid with no user' do
    drawing.user = nil
    drawing.should_not be_valid
  end

  it 'is valid with all attributes' do
    drawing.should be_valid
  end
end
