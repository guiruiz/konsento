class Team < ActiveRecord::Base
  extend FriendlyId

  friendly_id :title, use: :slugged

  has_many :subscriptions, as: :subscriptable
  has_many :topics
  has_many :team_invitations
  has_many :requirements, as: :requirable
  has_many :join_requirements, through: :requirements
  has_many :members, through: :subscriptions, source: :user

  accepts_nested_attributes_for :join_requirements, reject_if: :all_blank

  validates :title, presence: true

  def self.create_and_subscribe_admin(params, user)
    team = create(params)
    team.subscribe_admin(user) if team.persisted?
    team
  end

  def subscribe_admin(user)
    subscriptions.create(user: user, role: :admin)
  end
end
