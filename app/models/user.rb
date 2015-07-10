class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include ActiveModel::SecurePassword

  has_and_belongs_to_many :websites, inverse_of: nil
  
  field :email,               type: String
  field :password_digest,     type: String

  has_secure_password

  validates :email, presence: true
end
