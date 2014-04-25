class User < ActiveRecord::Base

  has_many :proficiencies
  has_many :skills, through: :proficiencies
  has_many :apprenticeships
  has_many :ratings
  has_many :conversations_by, class_name: "Conversation", inverse_of: :created_by
  has_many :conversations_for, class_name: "Conversation", inverse_of: :created_for
  has_many :messages

  accepts_nested_attributes_for :conversations_by
  accepts_nested_attributes_for :conversations_for

  PASSWORD_RESET_TIME_LIMIT = 1.day

  attr_accessor :password, :password_confirmation, :avatar

    # t.string   "email"
    # t.string   "salt"
    # t.string   "fish"
    # t.string   "reset_code"
    # t.datetime "reset_expires_at"
    # t.datetime "created_at"
    # t.datetime "updated_at"
    # t.string   "first_name"
    # t.string   "last_name"
    # t.string   "role"
    # t.boolean  "is_active"

  before_validation :format_attributes
  before_save :encrypt_password, if: :password
  before_create :set_random_password, unless: :password
  after_initialize :create_username
  after_initialize :set_active

  validates :email, format: { with: /.*@.*\..*/ }, uniqueness: { case_sensitive: false }
  validates :password, confirmation: true
  validates :is_active, inclusion: { :in => [true, false] }
  validates :first_name, format: { with: /\A([a-zA-Z]+)(\s{1}[a-zA-z]+)*\z/ }
  validates :last_name, format: { with: /\A([a-zA-Z]+)(\s{1}[a-zA-z]+)*\z/ }
  validates :role, format: { with: /(\Amaster\z)|(\Aapprentice\z)/ }

  has_attached_file :avatar, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>'
  }

  validates_attachment_content_type :avatar, :content_type => %w(image/jpeg image/jpg image/png)

  def set_active
    self.is_active = true if self.new_record?
  end

  def self.nil_expired_reset_codes
    User.where( "reset_expires_at < ?", Time.now.gmtime ).update_all(
      reset_code: nil,
      reset_expires_at: nil
    )
  end

  def self.find_by_code(code)
    User.nil_expired_reset_codes

    if user = User.find_by(
        "reset_code = ? AND reset_expires_at > ?", code, Time.now.gmtime
      )
      user.set_reset_expiration
    end

    user
  end

  def self.authenticate(email, password)
    user = User.find_by email: email
    user if user and user.authenticate(password)
  end

  def authenticate(password)
    self.fish == BCrypt::Engine.hash_secret(password, self.salt)
  end

  def set_reset_code
    self.reset_code = SecureRandom.urlsafe_base64
    set_reset_expiration
  end

  def set_reset_expiration
    self.reset_expires_at = PASSWORD_RESET_TIME_LIMIT.from_now
    self.save
  end

  def reset_password(user_params)
    if user_params[:password].blank?
      self.errors.add :password, "can't be blank"
      return false
    else
      if self.update_attributes( user_params )
        self.update_attributes(
          reset_code: nil,
          reset_expires_at: nil
        )
      end
    end
  end

  protected

  def format_attributes
    self.email.to_s.downcase!
    self.first_name = self.first_name.to_s.split.join(' ')
    self.last_name = self.last_name.to_s.split.join(' ')
  end

  def set_salt
    self.salt = BCrypt::Engine.generate_salt
  end

  def encrypt_password
    self.fish = BCrypt::Engine.hash_secret(password, set_salt)
  end

  def set_random_password
    if self.fish.blank?
      self.fish = BCrypt::Engine.hash_secret(SecureRandom.base64(32), set_salt)
    end
  end

  def create_username
    self.username = self.first_name + self.last_name
    self.username.downcase!
  end
end
