require "digest/sha2"

class User < ActiveRecord::Base

  has_and_belongs_to_many :products

  before_save :create_hashed_password
  after_save :clear_password

  attr_accessor :password

  validates_length_of :password, :minimum => 8, :on => :create 

  validates :email, :presence => true,
                    #:length => { :maxiumum => 50 }, 
                    :uniqueness => true,
                    #:format => { :with => EMAIL_REGEX },
                    :confirmation => true



  def self.authenticate(username = "", password = "")
    user = User.find_by_username(username)
    if user && user.password_match?(password)
      user
    else
      false
    end
  end


  def password_match?(password = "")
    self.hashed_password == User.hash_with_salt(password, salt)
  end


  def self.hash_with_salt(password="", salt = "")
    Digest::SHA2.hexdigest("Put #{salt} on the #{password}")
  end


  def self.make_salt(username = "")
    Digest::SHA2.hexdigest("Use #{username} with #{Time.now} to maek salt")
  end




############################################################################
  private
############################################################################

  def create_hashed_password
    # Whenever :password has a value hashing is needed
    unless password.blank?
      # always use "self" when assigning values
      self.salt = User.make_salt(username) if salt.blank?
      self.hashed_password = User.hash_with_salt(password, salt)
    end
  end

  def clear_password
    # for security and b/c hashing is not needed
    self.password = nil
  end


end
