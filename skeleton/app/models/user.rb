class User < ApplicationRecord
    after_initialize :ensure_session_token

    validates :user_name, :password_digest, :session_token, presence: true
    validates :user_name, :session_token, uniqueness: true 



    def reset_session_token!
        self.session_token = SecureRandom::urlsafe_base64
        self.save!
        self.session_token
    end

    def password=(pw)
        @password = pw
        password_digest = BCrypt::Password.create(pw)
    end

    def is_password?(pw)
        password_object =  BCrypt::Password.new(password_digest)
        password_object.is_password?(pw)
    end

    def self.find_by_credentials(username, password)
        user = User.find_by(user_name: username)
        if user && user.is_password?(password)
            return user
        else
            return nil
        end
    end

    

end