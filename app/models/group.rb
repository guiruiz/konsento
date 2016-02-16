class Group < ActiveRecord::Base
  include PgSearch
  extend FriendlyId

  pg_search_scope :search,
                  ignoring: :accents,
                  against: [:title, :description]

  pg_search_scope :suggestions,
                  ignoring: :accents,
                  against: [:title, :description],
                  using: {
                    tsearch: {any_word: true}
                  }

  friendly_id :title, use: [:scoped, :finders], scope: [:parent]

  has_many :children, inverse_of: :parent, class_name: 'Group', foreign_key: :parent_id
  belongs_to :parent, inverse_of: :children, class_name: 'Group', foreign_key: :parent_id
  has_many :subscriptions, as: :subscriptable
  has_many :topics
  has_many :requirements, as: :requirable
  has_many :join_requirements, through: :requirements
  has_many :users, through: :subscriptions

  scope :suggestions_for_location, -> (location = nil) do
    if location
      q = [
        location.city.presence,
        location.state.presence,
        location.country.presence,
        location.country_code.presence
      ].compact.join(' ')

      suggestions(q)
    else
      none
    end
  end

  def parents
    ancestry = [parent]

    while ancestry.last.try(:parent) && ancestry.size <= self.class.max_ancestry_size
      ancestry << ancestry.last.parent
    end

    ancestry.compact.reverse
  end

  def is_user_subscribed?(user)
    self.subscriptions.where(user: user).exists?
  end

  def self.max_ancestry_size
    5
  end
end
