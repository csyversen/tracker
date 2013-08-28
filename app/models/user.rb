require "digest/sha2"

class User < ActiveRecord::Base

  before_save :to_lower

  has_and_belongs_to_many :products
  has_secure_password

  validates :password, length: { minimum: 6 }

  
  validates :email, :presence => true,
                    #:length => { :maxiumum => 50 }, 
                    :uniqueness => { case_sensitive: false },
                    #:format => { :with => EMAIL_REGEX },
                    :confirmation => true




############################################################################
  private
############################################################################


  def to_lower
    self.email = self.email.downcase
  end

end
