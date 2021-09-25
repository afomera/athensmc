class Server < ApplicationRecord
  validates :name, presence: true
  validates :ssh_username, presence: true
  validates :ip, presence: true
  validates :game_port, presence: true
  validates :ssh_public_key, :encrypted_ssh_private_key, presence: true

  before_validation :generate_ssh_key

  attr_encrypted :ssh_private_key, key: Rails.application.credentials.ssh_secret

  def generate_ssh_key
    return if ssh_public_key?

    key = SSHKey.generate(comment: "[AthensMC - #{Rails.env}] #{name}")
    self.ssh_public_key = key.ssh_public_key
    self.ssh_private_key = key.private_key
  end
end
