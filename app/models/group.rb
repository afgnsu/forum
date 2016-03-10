class Group < ActiveRecord::Base
  validates :name, :presence => true
  has_many :posts
  #belongs_to :user
  belongs_to :owner, :class_name => "User", :foreign_key => :user_id
  paginates_per 10

  def editable_by?(user)
    user && user == owner
  end
end
