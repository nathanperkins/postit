module Voteable
  extend ActiveSupport::Concern

  included do
    has_many :votes, as: :voteable
  end

  def total_votes
    self.up_votes - self.down_votes
  end

  def up_votes
    self.votes.where(vote: true).size
  end

  def down_votes
    self.votes.where(vote: false).size
  end
end

# module Voteable
#   def self.included(base)
#     base.send(:include, InstanceMethods)
#     base.extend ClassMethods
#     base.class_eval do
#       my_class_method
#     end

#     has_many :votes, as: :voteable
#   end

#   module InstanceMethods
#     def total_votes
#       self.up_votes - self.down_votes
#     end

#     def up_votes
#       self.votes.where(vote: true).size
#     end

#     def down_votes
#       self.votes.where(vote: false).size
#     end
#   end

#   module ClassMethods
#     def my_class_method
#       puts "This is my class method"
#     end
#   end
# end