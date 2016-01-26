class Group < ActiveRecord::Base
  include PgSearch

  pg_search_scope :search,
                  ignoring: :accents,
                  against: [:title, :description]

  has_many :children, inverse_of: :parent, class_name: 'Group', foreign_key: :parent_id
  belongs_to :parent, inverse_of: :children, class_name: 'Group', foreign_key: :parent_id
  belongs_to :teams
  has_many :subscriptions, as: :subscriptable
  has_many :topics
  has_many :requirements, as: :requirable
  has_many :join_requirements, through: :requirements

  def parents
    ancestry = [parent]

    while ancestry.last.try(:parent) && ancestry.size <= 10
      ancestry << ancestry.last.parent
    end

    ancestry.compact
  end

  def is_user_subscribed?(user)
    self.subscriptions.where(user: user).exists?
  end
end
