require 'openssl'

class User < ApplicationRecord
  # параметры работы модуля шифрования паролей
  ITERATIONS = 20000
  DIGEST = OpenSSL::Digest::SHA256.new

  ALLOWED_USERNAME = /\A[a-z\d_]+\z/i
  ALLOWED_EMAIL = /.+@.+\..+/i

  attr_accessor :password

  has_many :questions

  validates :username, length: { maximum: 40 }, presence: true, uniqueness: true, format: { with: ALLOWED_USERNAME }

  validates :email, presence: true, uniqueness: true, format: { with: ALLOWED_EMAIL }

  validates_presence_of :password, on: :create
  validates_confirmation_of :password

  before_validation :username_downcase
  before_save :encrypt_password

  def self.authenticate(email, password)
    user = find_by(email: email)

    # Сравниваются password_hash, оригинальный пароль нигде не сохраняется вообще
    if user.present? && user.password_hash == User.hash_to_string(OpenSSL::PKCS5.pbkdf2_hmac(password, user.password_salt, ITERATIONS, DIGEST.length, DIGEST))
      user
    else
      nil
    end
  end

  # служебный метод, преобразующий бинарную строку в 16-ричный формат
  def self.hash_to_string(password_hash)
    password_hash.unpack('H*')[0]
  end

  def encrypt_password
    if self.password.present?
      # создаём соль
      self.password_salt = User.hash_to_string(OpenSSL::Random.random_bytes(16))

      # создаём хэш пароля
      self.password_hash = User.hash_to_string(
          OpenSSL::PKCS5.pbkdf2_hmac(self.password, self.password_salt, ITERATIONS, DIGEST.length, DIGEST)
      )
    end
  end

  def username_downcase
    self.username = username.downcase
  end
end
