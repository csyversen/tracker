class User < ActiveRecord::Base

  before_save :to_lower
  before_create :create_remember_token

  has_and_belongs_to_many :products
  has_secure_password

  validates :password, length: { minimum: 6 }

  
  validates :email, :presence => true,
                    #:length => { :maxiumum => 50 }, 
                    :uniqueness => { case_sensitive: false },
                    #:format => { :with => EMAIL_REGEX },
                    :confirmation => true



  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end


############################################################################
  private
############################################################################


  def to_lower
    self.email = self.email.downcase
  end

  def create_remember_token
    self.remember_token = User.encrypt(User.new_remember_token)
  end

end
