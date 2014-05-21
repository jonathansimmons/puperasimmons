module Tokenable
  extend ActiveSupport::Concern

  included do
    before_validation :generate_token, if: Proc.new { |tokenable| tokenable.uid.blank? }

    def to_param
      uid
    end
  end


  def generate_token
    self.uid = loop do
      random_token = SecureRandom.hex(5)
      break random_token unless self.class.exists?(uid: random_token)
    end
  end
end