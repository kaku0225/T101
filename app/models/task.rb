class Task < ApplicationRecord
  validates :name, presence: true
  validates :content, presence: true

  # validates :taiwanid, taiwanese_id: {message: "「您的身份證字號有誤，請確認後重新輸入」"}
end
