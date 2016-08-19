class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :orders
  belongs_to :role
  has_one :profile

  accepts_nested_attributes_for :profile, :allow_destroy => true

  before_create :set_default_role
  after_create :create_profile

  def role?(rolename)
    begin
      return self.role.name == rolename
    rescue
      return false
    end
  end

  private
  def set_default_role
    self.role ||= Role.find_by_name('Customer')
  end
end
