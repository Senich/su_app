module TestSpecHelper
  def create_and_login_user
    before do
      @john = User.create!(email: "user@example.com", password: "password", first_name: "John",
                           last_name: "Doe")
      login_as(@john)
    end
  end


end