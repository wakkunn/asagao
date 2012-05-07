class Vote < ActiveRecord::Base
  belongs_to :entry
  belongs_to :member

  attr_accessible :entry_id

  validate do
    unless member && member.votable_for?(entry)
      errors.add(:base, :invalid)
    end
  end
end
