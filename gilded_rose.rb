class GildedRose

  def initialize(items)
    @items = items
    @legendary = ["Sulfuras, Hand of Ragnaros"]
    @timeless = ["Aged Brie"]
    @conjured = ["Something conjured"]
  end

  def update_quality()
    @items.each do |item|
      if item.name != "Aged Brie" and item.name != "Backstage passes to a TAFKAL80ETC concert"
        if item.quality > 0
          if item.name != "Sulfuras, Hand of Ragnaros"
            item.quality = item.quality - 1
          end
        end
      else
        if item.quality < 50
          item.quality = item.quality + 1
          if item.name == "Backstage passes to a TAFKAL80ETC concert"
            if item.sell_in < 11
              if item.quality < 50
                item.quality = item.quality + 1
              end
            end
            if item.sell_in < 6
              if item.quality < 50
                item.quality = item.quality + 1
              end
            end
          end
        end
      end
      if item.name != "Sulfuras, Hand of Ragnaros"
        item.sell_in = item.sell_in - 1
      end
      if item.sell_in < 0
        if item.name != "Aged Brie"
          if item.name != "Backstage passes to a TAFKAL80ETC concert"
            if item.quality > 0
              if item.name != "Sulfuras, Hand of Ragnaros"
                item.quality = item.quality - 1
              end
            end
          else
            item.quality = item.quality - item.quality
          end
        else
          if item.quality < 50
            item.quality = item.quality + 1
          end
        end
      end
    end
  end

  def update_quality2()
    @items.each do |item|
      if is_legendary?(item)
        increase_quality(item, 1)
        next
      end
      if is_expired?(item) || is_conjured?(item)
        reduce_quality(item, 2)
        item.quality = 0 if is_backstage_pass?(item)
        next
      end
      if is_timeless?(item)
        increase_quality(item, 1)
        next
      end
      if is_backstage_pass?(item)
        increase_quality(item, 2) if item.sell_in <= 10
        increase_quality(item, 1) if item.sell_in <= 5
      end
    end
  end

  private

  def is_legendary?(item)
    @legendary.include?(item.name)
  end

  def is_timeless?(item)
    @timeless.include?(item.name)
  end

  def is_conjured?(item)
    @conjured.include?(item.name)
  end

  def is_backstage_pass?(item)
    item.name.downcase.include?("backstage pass")
  end

  def is_expired?(item)
    item.sell_in == 0 && !is_timeless?(item)
  end

  def reduce_quality(item, amount)
    item.quality -= amount if item.quality - amount >= 0
  end

  def increase_quality(item, amount)
    item.quality += amount if item.quality + amount <= 50
  end

end
