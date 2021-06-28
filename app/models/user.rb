class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :sessions, dependent: :destroy       
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  

  def self.is_valid_user(email,password)
    @user = User.find_by(email: email)
    @user and @user.valid_password?(password) ? @user : nil
  end

   def full_name
    self.first_name + " " + self.last_name
  end

end
