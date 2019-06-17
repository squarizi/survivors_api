class Complaint < ActiveRecord::Base
  COMPLAINT_LIMIT = 3

  before_create :can_create?
  after_create :verify_contamination

  belongs_to :complainer, class_name: 'Survivor'
  belongs_to :contaminated, class_name: 'Survivor'

  private

  def verify_contamination
    contamine! if contaminated?
  end

  def contamine!
    contaminated.contaminate_survivor!
  end

  def contaminated?
    Complaint.where(contaminated_id: contaminated_id).size >= COMPLAINT_LIMIT
  end

  def can_create?
    throw(:abort) if not_create?
  end

  def not_create?
    Complaint.where(complainer_id: complainer_id, contaminated_id: contaminated_id).any? ||
    Survivor.find(contaminated_id).blank? ||
    Survivor.find(complainer_id).blank?
  end
end
