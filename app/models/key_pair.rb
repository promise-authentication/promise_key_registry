class KeyPair < ApplicationRecord

  def self.generate!
    key = RbNaCl::PrivateKey.generate
    self.create(
      private_key: Base64.strict_encode64(key),
      public_key: Base64.strict_encode64(key.public_key),
    )
  end

  def attributes
    {
      public_key: nil,
      private_key: nil
    }
  end
end
