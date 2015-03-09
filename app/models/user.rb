class User < ActiveRecord::Base
  has_many :posts
  has_many :comments
  has_many :votes
  
  has_secure_password validations: false

  validates :username, presence: true, uniqueness: true
  validates_format_of :username, with: /\A[a-z][a-z0-9_]*[a-z0-9]\z/, message: "must contain only lowercase letters, numbers, and underscores"
  validates :password, presence: true, confirmation: true, length: {minimum: 5}, on: :create

  before_save :generate_slug

  def generate_slug
    the_slug = to_slug(self.username)

    user = User.find_by slug: the_slug
    count = 2
    
    while user && user != self
      the_slug = append_suffix(the_slug, count)
      user = User.find_by slug: the_slug
      count += 1
    end

    self.slug = the_slug
  end

  def append_suffix(str, count)
    if str.split('-').last.to_i != 0
      return str.split('-').slice(0...-1).join('-') + '-' + count.to_s
    else
      return str + '-' + count.to_s
    end
  end

  def to_slug(name)
    str = name.strip.downcase
    str = str.gsub(/\s*[^a-z0-9]\s*/,'-')
    str = str.gsub(/-+/, '-')
    str
  end

  def to_param
    self.slug
  end
end