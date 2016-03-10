class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :role
  has_many :groups, :dependent => :destroy
  has_many :posts, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  validates_presence_of :name
  before_save :assign_role


  def has_role?(role_name)
    self.role == Role.where(name: role_name).first
  end

=begin
  def add_role(role_name)
    role = Role.where(name: role_name).first
    self.role = role unless  role.blank?
  end
=end

  def assign_role
    #self.role = Role.find_by name: '訪客' if self.role.nil?
    self.role = Role.find_by name: 'Guest' if self.role.nil?
  end

  def admin?
    #self.role.name == '管理者'
    self.role.name == 'Admin'
  end

  def employee?
    #self.role.name == '職員'
    self.role.name == 'Employee'
  end

  def guest?
    #self.role.name == '訪客'
    self.role.name == 'Guest'
  end
end
