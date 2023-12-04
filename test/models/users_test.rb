require 'test_helper'

class UsersTest < ActiveSupport::TestCase

  test "need password" do
    pass = nil
    em = 'scott_engelhardt@outlook.com'
    check_fail(create_user(pass, em), pass)
  end
  
  test "need 8 char password" do
    pass = 'aA1!'
    em = 'scott_engelhardt@outlook.com'
    check_fail(create_user(pass, em), pass)
  end
  
  test "need lower case in password" do
    pass = 'AAAAAAAAA1!'
    em = 'scott_engelhardt@outlook.com'
    check_fail(create_user(pass, em), pass)
  end

  test "need upper case in password" do
    pass = 'aaaaaaaaa1!'
    em = 'scott_engelhardt@outlook.com'
    check_fail(create_user(pass, em), pass)
  end
  
  test "need numbers in password" do
    pass = 'aaaaaaaaaA!'
    em = 'scott_engelhardt@outlook.com'
    check_fail(create_user(pass, em), pass)
  end
  
  test "need special in password" do
    pass = 'aaaaaaaaaA'
    em = 'scott_engelhardt@outlook.com'
    check_fail(create_user(pass, em), pass)
  end
  
  test "need em" do
    pass = 'aaaaaaaaaA1!'
    em = nil
    check_fail(create_user(pass, em), em)
  end

  test "need valid email" do
    pass = 'aaaaaaaaaA1!'
    em = 'Scott'
    check_fail(create_user(pass, em), em)
  end

  test "need valid email 2" do
    pass = 'aaaaaaaaaA1!'
    em = 'Scott@'
    check_fail(create_user(pass, em), em)
  end

  test "need valid email 3" do
    pass = 'aaaaaaaaaA1!'
    em = 'Scott@outlook'
    check_fail(create_user(pass, em), em)
  end
  
  test "need unique em" do
    pass = 'aaaaaaaaaA1!'
    em = 'scott_engelhardt@outlook.com'
    u = create_user(pass, em)
    if u.save
      check_fail(create_user(pass, em), em)
    else
      puts '❌ Some error occured'
      assert false
    end
  end

  test "valid user" do
    pass = 'aaaaaaaaaA1!'
    em = 'scott_engelhardt@outlook.com'
    check_pass(create_user(pass, em))
  end
  
  test "valid user 2" do
    pass = 'sdfsdaASFASDF123!@##%$#'
    em = 'scott.engelhardt7@gmail.com'
    check_pass(create_user(pass, em))
  end

  test "valid user 3" do
    pass = 'Password123!'
    em = 'scott@mindstamp.io'
    check_pass(create_user(pass, em))
  end

  test "valid user 4" do
    pass = 'Password123!'
    em = 'scott@email.co'
    check_pass(create_user(pass, em))
  end
end

