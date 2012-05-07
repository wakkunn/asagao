class Entry < ActiveRecord::Base
  belongs_to :author, class_name: "Member", foreign_key: "member_id"
  has_many :votes, dependent: :destroy
  has_many :voters, through: :votes, source: :member

  STATUS_VALUES = %w(draft member_only public)

  validates :title, presence: true, length: { maximum: 200 }
  validates :body, :posted_at, presence: true
  validates :status, inclusion: { in: STATUS_VALUES }

  attr_accessible :title, :body, :posted_at, :status

  scope :common, where(status: "public")
  scope :published, where("status <> ?", "draft")
  scope :full, ->(member) { where("status <> ? OR member_id = ?",
                                  "draft", member.id) }
  scope :readable_for,
    ->(member) { member.kind_of?(Member) ? full(member) : common }

  class << self
    def status_text(status)
      I18n.t("activerecord.attributes.entry.status_#{status}")
    end
    
    def status_options
      STATUS_VALUES.map { |status| [status_text(status), status] }
    end
    
    def sidebar_entries(member, num = 5)
      readable_for(member).order("posted_at DESC").limit(num)
    end
  end
end
