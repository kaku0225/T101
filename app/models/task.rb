class Task < ApplicationRecord
  include AASM
  validates :name, presence: true
  validates :content, presence: true
  validates :endtime, presence: true
  validates :priority, presence: true

  # validates_presence_of :name, :message => :"任務名稱不可已是空白的"

  # validates :taiwanid, taiwanese_id: {message: "「您的身份證字號有誤，請確認後重新輸入」"}

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
