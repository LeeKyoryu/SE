class User < ApplicationRecord

  #self.primary_key = "uid"
  has_secure_password
  has_many :microposts, dependent: :destroy
  attr_accessor :remember_token, :activation_token
  before_create :generate_activation_token
  before_save :downcase_email
  validates :password, presence: true, allow_nil: true
  # validates :password_confirmation, presence: true
  validates :name, presence: true, length: { minimum: 2, maximum: 50 }
  # validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :email, presence: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i, message: "Email Format Invalid" }, uniqueness: { case_sensitive: false }

  # 计算用户的访问令牌并存至数据库
  def remember
    self.remember_token = User.new_token
    self.update_attribute(:remember_digest, User.digest(self.remember_token))
  end

  # 通用认证记忆令牌和激活令牌
  def authenticated?(attribute, token)
    digest = self.send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  # 清空用户访问令牌
  def forget
    self.update_attribute(:remember_digest, nil)
  end

  def feed
    Micropost.where("user_id = ?", self.id)
  end

  # 玩家当前关卡
  def level
    s = ""
    self.data.each_line {|line| s = line }
    s[0].to_i
  end

  # 展示玩家当前关卡
  def show_level
    s = self.level.to_s
    s == '0' ? '-' : s
  end

  private

    def generate_activation_token
      self.activation_token = User.new_token
      self.activation_digest = User.digest(self.activation_token)
    end

    def downcase_email
      self.email.downcase!
    end

  class << self

    def update_all_email
      User.update_all(email: 'educoder@educoder.net')
    end

    def delete_all_admin_user
      User.where(name: 'admin').destroy_all
    end

    # 返回提供参数 string 的散列摘要值
    def digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end

    # 返回一个22位长的随机字符串
    def new_token
      SecureRandom.urlsafe_base64
    end

  end

end
