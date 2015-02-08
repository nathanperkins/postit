class Comment < ActiveRecord::Base
  belongs_to :user, :post
end