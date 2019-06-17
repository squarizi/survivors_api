class SurvivorsItem < ActiveRecord::Base
  belongs_to :survivor

  enum item: { ammunition: 1, medicine: 2, food: 3, water: 4 }

  scope :ammunitions, -> { where(item: :ammunition) }

  scope :medicines, -> { where(item: :medicine) }

  scope :foods, -> { where(item: :food) }

  scope :waters, -> { where(item: :water) }

  scope :cronenbergeds_items, -> { joins(:survivor).merge Survivor.cronenbergeds }

  def update_amount!(amount, operator)
    self.amount = case operator
                  when :include
                    self.amount + amount
                  when :remove
                    self.amount - amount
                  end

    save!
  end
end
