class User < ApplicationRecord
  validates :email, presence:true, uniqueness:true,length:{maximum: 255}
    validates :username, presence:true, uniqueness:true,length:{maximum: 30}
    before_validation {username.downcase!}
    has_secure_password
    before_destroy :check_if_its_last_admin

    has_many :tasks, dependent: :destroy

    private

    def check_if_its_last_admin
        if self.admin? && User.where(admin: :true).count == 1
            throw :abort
        end
    end
end
