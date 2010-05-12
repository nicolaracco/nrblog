class Author < ActiveRecord::Base
  devise :database_authenticatable, :lockable, :recoverable, :rememberable, :trackable, :validatable

  has_many :contents

  def to_s
    self.username
  end
end
