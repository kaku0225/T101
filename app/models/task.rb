class Task < ApplicationRecord
  validates :name, presence: true
  validates :content, presence: true
  # validates_presence_of :name, :message => :"任務名稱不可已是空白的"

  # validates :taiwanid, taiwanese_id: {message: "「您的身份證字號有誤，請確認後重新輸入」"}
end
