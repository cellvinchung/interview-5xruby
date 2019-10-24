class User < ApplicationRecord
    has_secure_password
    validates :email, presence: true, uniqueness: true
    has_many :missions, dependent: :destroy
    enum role: {
        common: 0,
        admin: 1
    }
    before_destroy :check_last_admin, prepend: true
    def check_last_admin   
        throw :abort unless User.admin.count > 1
    end
end
