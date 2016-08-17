class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :orders
  belongs_to :role
  has_one :profile

  def role?(rolename)
    begin
      return self.role.name == rolename
    rescue
      return false
    end
  end
end
