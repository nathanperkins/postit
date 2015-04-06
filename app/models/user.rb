class User < ActiveRecord::Base
  require 'twilio-ruby'
  include Sluggable

  has_many :posts
  has_many :comments
  has_many :votes
  
  has_secure_password validations: false

  validates :username, presence: true, uniqueness: true
  validates_format_of :username, with: /\A[a-z][a-z0-9_]*[a-z0-9]\z/, message: "must contain only lowercase letters, numbers, and underscores"
  validates :password, presence: true, confirmation: true, length: {minimum: 5}, on: :create

  sluggable_column :username

  def two_factor_auth?
    !self.phone.blank?
  end

  def generate_pin!
    self.update_column(:pin, rand(10 ** 6)) # random 6 digit number
  end

  def remove_pin!
    self.update_column(:pin, nil) # random 6 digit number
  end

  def send_pin_to_twilio!
    # put your own credentials here 
    account_sid = ENV['TWILIO_API_KEY']
    auth_token = ENV['TWILIO_AUTH_TOKEN']
     
    # set up a client to talk to the Twilio REST API 
    client = Twilio::REST::Client.new account_sid, auth_token 

    client.account.messages.create({
      :from => '+14157921434', 
      :to => '+1' + self.phone, 
      :body => 'Hello, here is your PostIt! authorization PIN: ' + self.pin.to_s
    })
  end

  def admin?
    self.role == 'admin'
  end

  def moderator?
    self.role == 'moderator'
  end
end