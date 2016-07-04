class ProfileCreator::Base
  def initialize(user)
    @user = user
  end

  private

  def generate_unique_nickname(nickname)
    n = 0
    unique_nickname = nickname

    while Profile.by_nickname(unique_nickname).exists?
      n += 1
      unique_nickname = "#{nickname}-#{n}"
    end

    unique_nickname
  end
end
