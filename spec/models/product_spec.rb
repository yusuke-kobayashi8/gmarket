require 'rails_helper'

RSpec.describe Product, type: :model do
  it "finds a searched product by name" do
    @result = Product.search("pro")
  end
end