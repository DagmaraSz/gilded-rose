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

    it "never reduces quality of item below 0" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 0
    end

    it "increases the quality of Aged Brie as it gets older" do
      items = [Item.new("Aged Brie", 6, 5)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 6
    end

    it "never increases the quality of an item above 50" do
      items = [Item.new("Aged Brie", 6, 50)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 50
    end

    it "knows Sulfuras, being a legendary item, never decreases in quality" do
      items = [Item.new("Sulfuras, Hand of Ragnaros", 0, 10)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 10
    end

    it "knows Sulfuras, being a legendary item, never has to be sold" do
      items = [Item.new("Sulfuras, Hand of Ragnaros", 3, 10)]
      GildedRose.new(items).update_quality()
      expect(items[0].sell_in).to eq 3
    end

    it "increases quality of Backstage Passes by 2 when there are 10 days or less left" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 10)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 12
    end

    it "increases quality of Backstage Passes by 3 when there are 5 days or less" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 10)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 13
    end

    it "drops quality of Backstage Passes to 0 after the concert" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 10)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 0
    end

    xit "degrades the quality of conjured items twice as fast as normal items" do

    end

  end

end
