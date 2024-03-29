class User < ActiveRecord::Base
  # Connects this user object to Hydra behaviors.
  include Hydra::User
  include CanCan::Ability

  # Connects this user object to Blacklights Bookmarks.
  include Blacklight::User

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :pid, :gn, :sn
  attr_accessor :gn, :sn, :pid, :name

  # Method added by Blacklight; Blacklight uses #to_s on your
  # user class to get a user-displayable login/identifier for
  # the account. 
  def to_s
    name
  end

  def new_record?
    pid.nil?
  end

  #environment includes a list of pids that should have admin privileges
  def admin?
    if APP_CONFIG['admin_pids']
      APP_CONFIG['admin_pids'].include?(pid)
    else
      false
    end
  end
end
