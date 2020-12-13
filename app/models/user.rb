class User < ApplicationRecord
  has_many :tasks, dependent: :destroy
  validates :username , presence:true
  validates :email , presence:true, length: { maximum: 255 }, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, uniqueness: true
  before_validation { email.downcase! }
  has_secure_password
  validates :password, length: { minimum: 6 }, on: :create
  before_destroy :before_admin_destroy
  before_update :before_admin_update

  private

  def before_admin_destroy
    throw(:abort) if User.where(admin: true).count <= 1 && self.admin == true
  end

  def before_admin_update
    if User.where(admin: true).count == 1 && self.admin == false
      errors.add(:admin,"Atleast one admin is required")
      throw(:abort)
    end
  end
end
def check_can_change_admin
    if User.where(admin: true).count == 1 && self.admin_change == [true, false]
      errors.add :base, '管理者が一人以上必要なため、権限の変更はできません'
      throw(:abord)
    #   throw :abort if User.where(admin: true).count == 1 && admin == false
    end
  end
