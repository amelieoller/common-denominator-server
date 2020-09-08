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
      friendship.update(harmony: params[:harmony], randomness: params[:randomness], vetoes: params[:vetoes])

      render json: friendship
    else
      render json: { errors: ["Error updating friendship"] }
    end
  end

  def get_result_for_category
    category = Category.find(params[:id])
    friendship = category.friendship
    userA = friendship.user
    userB = friendship.friend
    harmony_coefficient = friendship.harmony
    random_multiplier = (2 + harmony_coefficient * 5) * friendship.randomness
    random_term = rand(0..random_multiplier)

    results = category.items.map do |item|
      ratings = item.ratings

      ratingA = ratings[0].user == userA ? ratings[0] : ratings[1]
      ratingB = ratings[0].user == userB ? ratings[0] : ratings[1]

      voteA = ratingA.value
      voteB = ratingB.value

      difference = (voteA - voteB).abs

      privilegeA = userA.privilege
      privilegeB = userB.privilege

      result = (privilegeA * voteA) + (privilegeB * voteB) + (harmony_coefficient * voteA * voteB) - harmony_coefficient * difference + random_term

      result
    end
    puts category.items.map { |i| i.title }
    puts results

    result_index = results.each_with_index.max[1]
    result_item = category.items[result_index]

    render json: { result: result_item }
    update_privilege(userA, userB, result_item, random_term)
  end

  # not working yet
  def update_privilege(userA, userB, result_item, random_term)
    ratings = result_item.ratings
    ratingA = ratings[0].user == userA ? ratings[0] : ratings[1]
    ratingB = ratings[0].user == userB ? ratings[0] : ratings[1]

    privilegeA = userA.privilege
    privilegeB = userB.privilege

    voteA = ratingA.value
    voteB = ratingB.value

    privilegeMultiplierA = ((privilegeA * (voteB - voteA)) / 10) + privilegeA
    privilegeMultiplierB = ((privilegeB * (voteA - voteB)) / 10) + privilegeB

    delta = 2 / (privilegeMultiplierA + privilegeMultiplierB)

    newPrivilegeA = (privilegeMultiplierA * delta).round(2)
    newPrivilegeB = (privilegeMultiplierB * delta).round(2)

    userA.update(privilege: newPrivilegeA)
    userB.update(privilege: newPrivilegeB)

    puts "#{random_term} AAAAA #{userA.username}, Vote: #{voteA}, Before P: #{privilegeA}, After P: #{userA.privilege}"
    puts "#{random_term} BBBBB #{userB.username}, Vote: #{voteB}, Before P: #{privilegeB}, After P: #{userB.privilege}"
  end
end
