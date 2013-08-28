require "digest/sha2"

class User < ActiveRecord::Base

  has_and_belongs_to_many :products

  before_save :create_hashed_password
  after_save :clear_password

  attr_accessor :password

  validates_length_of :password, :minimum => 8, :on => :create 

  validates :email, :presence => true,
                    #:length => { :maxiumum => 50 }, 
                    :uniqueness => { case_sensitive: false },
                    #:format => { :with => EMAIL_REGEX },
                    :confirmation => true



  def self.authenticate(email = "", password = "")
    user = User.find_by(email: email)
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


  def self.make_salt(email = "")
    Digest::SHA2.hexdigest("Use #{email} with #{Time.now} to maek salt")
  end




############################################################################
  private
############################################################################

  def create_hashed_password
    # Whenever :password has a value hashing is needed
    unless password.blank?
      # always use "self" when assigning values
      self.salt = User.make_salt(email) if salt.blank?
      self.hashed_password = User.hash_with_salt(password, salt)
    end
  end

  def clear_password
    # for security and b/c hashing is not needed
    self.password = nil
  end


end
