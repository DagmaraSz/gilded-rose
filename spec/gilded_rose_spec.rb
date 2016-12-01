require_relative '../gilded_rose'
require_relative '../item'

describe GildedRose do

  describe "#update" do

    it "does not change the item name" do
      items = [Item.new("foo", 3, 5)]
      GildedRose.new(items).update()
      expect(items[0].name).to eq "foo"
    end

    context "Update item sell_in" do
      it "reduces the sell in date every day" do
        items = [Item.new("foo", 3, 5)]
        expect{
          GildedRose.new(items).update()
        }.to change {items[0].sell_in}.by(-1)
      end
      it "doesn't change the sell_in of legendary items (Sulfuras)" do
        items = [Item.new("Sulfuras, Hand of Ragnaros", 3, 5)]
        expect{
          GildedRose.new(items).update()
        }.to change {items[0].sell_in}.by(0)
      end
    end

    context "Update item quality" do

      it "reduces the quality twice faster once the sell by date has passed" do
        items = [Item.new("foo", 0, 5)]
        expect{
          GildedRose.new(items).update()
        }.to change {items[0].quality}.by(-2)
      end

      it "never reduces quality of item below 0" do
        items = [Item.new("foo", 0, 0)]
        GildedRose.new(items).update()
        expect(items[0].quality).to eq 0
      end

      it "increases the quality of Aged Brie as it gets older" do
        items = [Item.new("Aged Brie", 6, 5)]
        GildedRose.new(items).update()
        expect(items[0].quality).to eq 6
      end

      it "never increases the quality of an item above 50" do
        items = [Item.new("Aged Brie", 6, 50)]
        GildedRose.new(items).update()
        expect(items[0].quality).to eq 50
      end

      it "knows Sulfuras, being a legendary item, never decreases in quality" do
        items = [Item.new("Sulfuras, Hand of Ragnaros", 0, 10)]
        GildedRose.new(items).update()
        expect(items[0].quality).to eq 11
      end

      it "knows Sulfuras, being a legendary item, never has to be sold" do
        items = [Item.new("Sulfuras, Hand of Ragnaros", 3, 10)]
        GildedRose.new(items).update()
        expect(items[0].sell_in).to eq 3
      end

      it "increases quality of Backstage Passes by 2 when there are 10 days or less left" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 10)]
        GildedRose.new(items).update()
        expect(items[0].quality).to eq 12
      end

      it "increases quality of Backstage Passes by 3 when there are 5 days or less" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 10)]
        GildedRose.new(items).update()
        expect(items[0].quality).to eq 13
      end

      it "drops quality of Backstage Passes to 0 after the concert" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 10)]
        GildedRose.new(items).update()
        expect(items[0].quality).to eq 0
      end

      xit "degrades the quality of conjured items twice as fast as normal items" do

      end

    end

  end

end
