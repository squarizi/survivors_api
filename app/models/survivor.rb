require 'hash_serializer'
class Survivor < ActiveRecord::Base
  attr_accessor :items

  serialize :last_location, HashSerializer

  store_accessor :last_location, :lat, :lng

  validates :name, :birth_date, :gender, :last_location, presence: true

  enum gender: { female: 1, male: 2 }

  has_many :survivor_items, class_name: 'SurvivorsItem', foreign_key: :survivor_id, dependent: :destroy

  has_many :send_complaints, class_name: 'Complaint', foreign_key: :complainer_id

  has_many :received_complaints, class_name: 'Complaint', foreign_key: :contaminated_id

  scope :cronenbergeds, -> { where(contaminated: :true) }

  after_save :set_items

  def contaminated?
    contaminated
  end

  def contaminate_survivor!
    self.contaminated = true
    save!
  end

  def include_items!(items)
    manage_items(items, :include)
  end

  def remove_items!(items)
    manage_items(items, :remove)
  end

  private

  def manage_items(items, operator)
    items.map do |item|
      si = survivor_items.find_by(item: item[:item_id])
      si.update_amount!(item[:amount], operator)
    end
  end

  def set_items
    return unless items.present?

    items.map do |item|
      SurvivorsItem.create(
        survivor_id: id,
        item: item[:item_id],
        amount: item[:amount]
      )
    end
  end
end
