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

  # scope :find_pending, -> { where(state: "pending") }
  # scope :find_progress, -> { where(state: "progress") }
  # scope :find_complete, -> { where(state: "complete") }
  scope :find_and_order, -> (data) {
    if data.present?
      if data == "endtime_asc"
        @tasks = Task.endtime_asc
      elsif data == "endtime_desc"
        @tasks = Task.endtime_desc
      elsif data == "priority_asc"
        @tasks = Task.important
      elsif data == "priority_desc"
        @tasks = not_important
      elsif data == "pending"
        @tasks = Task.where(state: "pending")
      elsif data == "progress"
        @tasks = Task.where(state: "progress")
      elsif data == "complete"
        @tasks = Task.where(state: "complete")
      end
    else
      @tasks = Task.all
    end
  }

  # scope :find_order, -> (order) {
  #   if order == "endtime_asc"
  #     @tasks = Task.endtime_asc
  #   elsif order == "endtime_desc"
  #     @tasks = Task.endtime_desc
  #   elsif order == "priority_asc"
  #     @tasks = Task.important
  #   elsif order == "priority_desc"
  #     @tasks = not_important
  #   end
  # }
  
  # scope :find_state, -> (state) { 
  #   if state == "pending"
  #     @tasks = Task.where(state: "pending")
  #   elsif state == "progress"
  #     @tasks = Task.where(state: "progress")
  #   elsif state == "complete"
  #     @tasks = Task.where(state: "complete")
  #   end
  # }


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
