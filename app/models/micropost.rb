class Micropost < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: { message: "内容不能为空" }, length: { maximum: 140, message: "内容不能超过140字" }
end
