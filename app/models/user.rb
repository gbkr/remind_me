class User < ActiveRecord::Base
 
  has_many :events

  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable, :confirmable, :lockable

  # https://github.com/mwlang/lazy_registration_demos

  def password_required?
    # Password is required if it is being set, but not for new records
    if !persisted? 
      false
    else
      !password.nil? || !password_confirmation.nil?
    end
  end

  # provide access to protected method unless_confirmed
  def only_if_unconfirmed
    pending_any_confirmation { yield }
  end

  # set the password without knowing the current password used in our confirmation controller. 
  def update_password(params)
    update_attributes({password: params[:password], password_confirmation: params[:password_confirmation], time_zone: params[:time_zone]})
  end

  def blank_password?
    self.encrypted_password.blank?
  end
end
