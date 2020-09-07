class Api::V1::FriendshipsController < ApplicationController
  def show
    user_id = current_user.id

    friend_id = params[:id].to_i

    custom_friendship_id = generate_custom_friendship_id(user_id, params[:id].to_i)
    friendship = Friendship.where("custom_friendship_id = ?", custom_friendship_id).take

    if friendship
      render json: friendship, include: ["categories", "categories.items"]
    else
      render json: { errors: ["Error fetching friendship"] }
    end
  end

  def update
    friendship = Friendship.find(params[:id])

    if friendship
      friendship.update(harmony: params[:harmony], randomness: params[:randomness])

      render json: friendship
    else
      render json: { errors: ["Error updating friendship"] }
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

    render json: { result: result_item }
    # update_privilege(result_item)
  end

  # not working yet
  def update_privilege(result_item)
    ratingA = result_item.ratings[0]
    ratingB = result_item.ratings[1]

    userA = ratingA.user
    userB = ratingB.user

    privilegeA = userA.privilege
    privilegeB = userB.privilege

    voteA = ratingA.value
    voteB = ratingB.value

    newPrivilegeA = privilegeA * ((voteB - voteA) / 10)
    newPrivilegeB = privilegeB * ((voteA - voteB) / 10)

    userA.update(privilege: newPrivilegeA)
    userB.update(privilege: newPrivilegeB)

    puts "AAAAA Vote: #{voteA}, Before P: #{privilegeA}, After P: #{userA.privilege}"
    puts "BBBBB Vote: #{voteB}, Before P: #{privilegeB}, After P: #{userB.privilege}"
  end
end
