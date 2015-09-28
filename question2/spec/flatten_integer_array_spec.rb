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

    it "should return a flat array given a shallow arbitrarily nested array of integers with an empty array interspersed" do
      shallow_with_empty_array = [1,2,3,[], 4]
      expect(FlattenIntegerArray.flatten(shallow_with_empty_array)).to eq([1,2,3,4])
    end

    it "should return a flat array given a deeply nested array of integers" do
      deeply_nested_array = [1,2,3,[1,2,3,[1,2,3,[1,2,3],4],4],4]
      expect(FlattenIntegerArray.flatten(deeply_nested_array)).to eq([1,2,3,1,2,3,1,2,3,1,2,3,4,4,4])
    end

    it "should return a flat array of arbitrarily nested array of integers without removing duplicates" do
      array = [1,2,3,4,1,2,3,4,[1,2,3,4]]
      expect(FlattenIntegerArray.flatten(array)).to eq([1,2,3,4,1,2,3,4,1,2,3,4])
    end
  end
end
