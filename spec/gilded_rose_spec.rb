require_relative '../gilded_rose'
require_relative '../item'

describe GildedRose do

  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("foo", 3, 5)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
    end

    it "reduces the quality twice faster once the sell by date has passed" do
      items = [Item.new("foo", 0, 5)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 3
    end

    xit "never reduces quality of item below 0" do

    end

    xit "increases the quality of Aged Brie as it gets older" do

    end

    xit "never increases the quality of an item above 50" do

    end

    xit "knows Sulfuras, being a legendary item, never has to be sold or decreases in Quality" do

    end

    xit "increases quality of Backstage Passes by 2 when there are 10 days or less left" do

    end

    xit "increases quality of Backstage Passes by 3 when there are 5 days or less" do

    end

    xit "drops quality of Backstage Passes to 0 after the concert" do

    end

    xit "degrades the quality of conjured items twice as fast as normal items" do

    end

  end

end
