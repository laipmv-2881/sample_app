module UsersHelper
  def downcase_email
    self.email = email.downcase!
  end
end
