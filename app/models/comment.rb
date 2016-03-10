class Comment < ActiveRecord::Base
  belongs_to :post, counter_cache: true
  #belongs_to :user
  belongs_to :owner, :class_name => "User", :foreign_key => :user_id
  paginates_per 5

  def editable_by?(user)
    user && user == owner
  end
end
