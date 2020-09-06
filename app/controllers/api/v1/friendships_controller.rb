class Api::V1::FriendshipsController < ApplicationController
  def show
    user_id = current_user.id
    friend_id = params[:id].to_i

    custom_friendship_id = generate_custom_friendship_id(current_user.id, params[:id].to_i)
    friendship = Friendship.where("custom_friendship_id = ?", custom_friendship_id).take

    if friendship
      render json: friendship
    else
      render json: { errors: ["Error fetching friendship"] }
    end
  end

  def get_result_for_category
    category = Category.find(params[:id])

    results = category.items.map do |item|
      ratings = item.ratings

      ratingA = ratings[0]
      ratingB = ratings[1]

      voteA = ratingA.value
      voteB = ratingB.value

      difference = (voteA - voteB).abs

      privilegeA = ratingA.user.privilege
      privilegeB = ratingB.user.privilege

      harmony_coefficient = 0.5
      # random_term = 1

      result = (privilegeA * voteA) + (privilegeB * voteB) + (harmony_coefficient * voteA * voteB) - harmony_coefficient * difference

      result
    end

    result_index = results.each_with_index.max[1]
    result_item = category.items[result_index]

    # update_privilege(result_item)

    render json: { result: result_item }
  end

  # not working yet
  def update_privilege(result_item)
    ratingA = result_item.ratings[0]
    ratingB = result_item.ratings[1]

    userA = ratingA.user
    userB = ratingB.user
    byebug

    privilegeA = userA.privilege
    privilegeB = userB.privilege

    voteA = ratingA.value
    voteB = ratingB.value

    newPrivilegeA = ((privilegeA * (voteA - voteB)) / 5) + 1
    newPrivilegeB = ((privilegeB * (voteB - voteA)) / 5) + 1

    # userA.privilege = newPrivilegeA
    # userB.privilege = newPrivilegeB
    # userB.privilege = newPrivilegeB
    puts privilegeA
    puts privilegeB
    puts userA.privilege
    puts userB.privilege
  end
end
