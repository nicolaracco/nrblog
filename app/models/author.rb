class Author < ActiveRecord::Base
  devise :database_authenticatable, :lockable, :recoverable, :rememberable, :trackable, :validatable

  has_many :contents, :dependent => :destroy

  def to_s
    self.username
  end
end
