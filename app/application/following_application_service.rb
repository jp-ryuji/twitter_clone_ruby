# frozen_string_literal: true

class FollowingApplicationService
  def follow_user(follower_id, following_user_id)
    follower = User.find(follower_id)
    following_user = User.find(following_user_id)

    # Use the domain method from the User model
    follower.follow(following_user)
  end

  def unfollow_user(follower_id, following_user_id)
    follower = User.find(follower_id)
    following_user = User.find(following_user_id)

    # Use the domain method from the User model
    follower.unfollow(following_user)
  end

  def get_following_users(user_id, page = 1)
    User.find(user_id).following_users.page(page)
  end

  def get_followers(user_id, page = 1)
    User.find(user_id).followers.page(page)
  end
end
