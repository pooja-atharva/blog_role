class Ability
  include CanCan::Ability

  def initialize(user)
    user.role.permissions.each do |permission|
      if permission.subject_class == "all"
        can permission.action.to_sym, permission.subject_class.to_sym
      else
        can permission.action.to_sym, permission.subject_class.constantize
      end
    end
  end

  # def initialize(user)
  #   can :read, Post, public: true

  #   if user.present?  # additional permissions for logged in users (they can read their own posts)
  #     can :read, Post
  #     # , user_id: user.id
  #     if user.admin?  # additional permissions for administrators
  #       can :manage, Post
  #     end
  #   end
  # end
end