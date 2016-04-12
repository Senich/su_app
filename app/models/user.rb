class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :products
  belongs_to :company

  validates :first_name, presence: true
  validates :last_name, presence: true

  def full_name
    "#{first_name} #{last_name}"
  end

  def make_admin!
    self.update(role: 'admin')
  end

  def make_seller!
    self.update(role: 'seller')
  end

  def make_user!
    self.update(role: 'user')
  end

  def admin?
    self.role == 'admin'
  end

  def seller?
    self.role == 'seller'
  end

  def user?
    self.role == 'user'
  end

end
