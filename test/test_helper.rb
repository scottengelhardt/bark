ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  fixtures :all


  def get_id
    SecureRandom.uuid
  end

  def create_user(pass, email)
    u = User.new(first: 'Scott', last: 'Engelhardt', id: get_id)
    u.email = email if email
    u.password = pass if pass
    u
  end

  def check_fail(user, x)
    if !user.save
      puts "✅ #{x}: #{user.errors.full_messages[0]}"
      assert true
    else
      assert false
    end
  end
  
  def check_pass(user)
    assert user.save
  end

end
