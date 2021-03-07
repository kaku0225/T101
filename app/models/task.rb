class Task < ApplicationRecord
  include AASM
  validates :name, presence: true
  validates :content, presence: true
  validates :endtime, presence: true
  validates :priority, presence: true
  enum priority: { low: 0, medium: 1 ,high: 2 }

  # validates_presence_of :name, :message => :"任務名稱不可已是空白的"

  # validates :taiwanid, taiwanese_id: {message: "「您的身份證字號有誤，請確認後重新輸入」"}

  # scope :important -> { where("priority=low") }
  # scope :endtime -> { where("endtime=2021-03-25")}

  scope :important, -> { order("priority desc") }
  scope :not_important, -> { order("priority asc") }

  scope :endtime_asc, -> { order("endtime asc") }
  scope :endtime_desc, -> { order("endtime desc") }

  scope :find_pending, -> { where(state: "pending") }
  scope :find_progress, -> { where(state: "progress") }
  scope :find_complete, -> { where(state: "complete") }


  aasm(column: 'state', no_direct_assignment: true) do 
    state :pending, initial: true
    state :progress, :complete

    event :progress do
      transitions from: :pending, to: :progress
    end

    event :complete do
      transitions from: :progress, to: :complete
    end
  end
end
