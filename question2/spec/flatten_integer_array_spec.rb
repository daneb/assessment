require 'spec_helper.rb'

describe FlattenIntegerArray do
  describe "Flatten an arbitrarily nested array of integers" do
    it "should inform the user when there is no input given" do
      error_message = 'This is not an arbitrarily nested array of integers'
      expect{FlattenIntegerArray.flatten()}.to raise_exception(ArgumentError)
    end

    it "should return a flat array of integers when given one" do
      flat_array = [1,2,3,4]
      expect(FlattenIntegerArray.flatten(flat_array)).to eq(flat_array)
    end

    it "should return a flat array given a shallow arbitrarily nested array of integers" do
      shallow_array = [1,2,3,[1,2,3]]
      expect(FlattenIntegerArray.flatten(shallow_array)).to eq([1,2,3,1,2,3])
    end
  end
end