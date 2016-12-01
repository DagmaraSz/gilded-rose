class GildedRose

  def initialize(items)
    @items = items
    @legendary = ["Sulfuras, Hand of Ragnaros"]
    @timeless = ["Aged Brie"]
    @conjured = ["Something conjured"]
  end

  def update()
    @items.each do |item|
      update_sell_in(item)
      update_quality(item)
    end
  end


  private

  def update_sell_in(item)
    item.sell_in -= 1 unless is_legendary?(item)
  end

  def update_quality(item)
    increase_quality(item, 1) if is_legendary?(item) || is_timeless?(item)
    reduce_quality(item, 2) if is_conjured?(item) || is_expired?(item)
    if is_backstage_pass?(item)
      increase_quality(item, 2) if item.sell_in <= 10
      increase_quality(item, 1) if item.sell_in <= 5
      item.quality = 0 if is_expired?(item)
    end
  end

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
    item.sell_in <= 0 && !(is_timeless?(item) || is_legendary?(item))
  end

  def reduce_quality(item, amount)
    item.quality -= amount if item.quality - amount >= 0
  end

  def increase_quality(item, amount)
    item.quality += amount if item.quality + amount <= 50
  end

end
