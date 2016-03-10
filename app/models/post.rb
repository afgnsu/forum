class Post < ActiveRecord::Base
  validates :title, :content, :presence => true
  belongs_to :group, counter_cache: true
  #belongs_to :user
  belongs_to :owner, :class_name => "User", :foreign_key => :user_id
  has_many :comments
  paginates_per 10

  def editable_by?(user)
    user && user == owner
  end

end
