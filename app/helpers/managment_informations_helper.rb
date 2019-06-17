module ManagmentInformationsHelper

  def items_count(item_symbol)
    survivor_items = SurvivorsItem.public_send(item_symbol)
    return 0 if survivor_items.blank?

    survivor_items.map.inject(0) { |sum, i| sum + i.amount } / count_survivor
  end

  def lost_points
    cronenbergeds_items = SurvivorsItem.cronenbergeds_items
    return 0 if cronenbergeds_items.blank?

    cronenbergeds_items.map.inject(0) { |sum, i| sum + (i.item.value * i.amount) }
  end

  def cronenbergeds_porcentage
    (Survivor.cronenbergeds.count(:id) / count_survivor) * 100
  end

  def clean_percentage
    100 - cronenbergeds_porcentage
  end

  private

  def count_survivor
    @count_survivor ||= Survivor.count(:id).to_f
  end
end
