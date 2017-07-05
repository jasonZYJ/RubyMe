class Ability
  include CanCan::Ability

  attr_reader :user

  def initialize(u)
    @user = u
    if @user.blank?
      roles_for_anonymous
    elsif @user.roles?(:admin)
      can :manage, :all
    elsif @user.roles?(:member)
      roles_for_members
    else
      roles_for_anonymous
    end
  end

  protected

  # 普通会员权限
  def roles_for_members
    roles_for_posts
    roles_for_replies
    roles_for_notes
    roles_for_comments
    roles_for_photos
    roles_for_sites
    roles_for_teams
    roles_for_team_users
    basic_read_only
  end

  def roles_for_anonymous
    cannot :manage, :all
    basic_read_only
  end

  def roles_for_posts
    unless user.newbie?
      can :create, Post
    end
    can [:favorite, :unfavorite, :follow, :unfollow], Post
    can [:update, :open, :close], Post, user_id: user.id
    can :change_node, Post, user_id: user.id, lock_node: false
    can :destroy, Post do |post|
      post.user_id == user.id && post.replies_count == 0
    end
  end

  def roles_for_replies
    # 新手用户晚上禁止回帖，防 spam，可在面板设置是否打开
    can :create, Reply unless current_lock_reply?
    can [:update, :destroy], Reply, user_id: user.id
    cannot [:create, :update, :destroy], Reply, topic: { closed?: true }
  end

  def current_lock_reply?
    return false unless user.newbie?
    return false if Setting.reject_newbie_reply_in_the_evening != 'true'
    Time.zone.now.hour > 22 || Time.zone.now.hour < 9
  end

  def roles_for_notes
    can :create, Note
    can [:update, :destroy, :read], Note, user_id: user.id
    can :read, Note, publish: true
  end

  def roles_for_photos
    can :tiny_new, Photo
    can :create, Photo
    can :update, Photo, user_id: user.id
    can :destroy, Photo, user_id: user.id
  end

  def roles_for_comments
    can :create, Comment
    can :update, Comment, user_id: user.id
    can :destroy, Comment, user_id: user.id
  end

  def roles_for_sites
    if user.roles?(:site_editor)
      can :create, Site
    end
  end

  def roles_for_teams
    if user.roles?(:wiki_editor)
      can :create, Team
    end
    can [:update, :destroy], Team do |team|
      team.owner?(user)
    end
  end

  def roles_for_team_users
    can :read, TeamUser, user_id: user.id
    can :accept, TeamUser, user_id: user.id
    can :reject, TeamUser, user_id: user.id
  end

  def basic_read_only
    can :read, :all
  end
end
