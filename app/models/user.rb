# == Schema Information
#
# Table name: users
#
#  id                             :bigint           not null, primary key
#  avatar_url                     :string
#  bio                            :string
#  confirmation_sent_at           :datetime
#  confirmation_token             :string
#  confirmed_at                   :datetime
#  current_sign_in_at             :datetime
#  current_sign_in_ip             :string
#  email                          :string           default(""), not null
#  email_notifications            :boolean          default(FALSE)
#  encrypted_password             :string           default(""), not null
#  invitation_accepted_at         :datetime
#  invitation_created_at          :datetime
#  invitation_limit               :integer
#  invitation_sent_at             :datetime
#  invitation_token               :string
#  invitations_count              :integer          default(0)
#  invited_by_type                :string
#  last_sign_in_at                :datetime
#  last_sign_in_ip                :string
#  location                       :string
#  name                           :string
#  new_article_notifications_freq :integer          default("daily")
#  notifications_freq             :integer          default("instantly")
#  performance_notifications_freq :integer          default("daily")
#  product_notifications          :boolean          default(TRUE)
#  provider                       :string
#  remember_created_at            :datetime
#  reset_password_sent_at         :datetime
#  reset_password_token           :string
#  sign_in_count                  :integer          default(0), not null
#  timezone                       :string           default("UTC")
#  uid                            :string
#  unconfirmed_email              :string
#  username                       :string
#  website                        :string
#  created_at                     :datetime         not null
#  updated_at                     :datetime         not null
#  invited_by_id                  :bigint
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_invitation_token      (invitation_token) UNIQUE
#  index_users_on_invited_by            (invited_by_type,invited_by_id)
#  index_users_on_invited_by_id         (invited_by_id)
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and 


  devise :invitable, :database_authenticatable, :registerable,

         :recoverable, :rememberable, :validatable, :confirmable, :omniauthable, omniauth_providers: [:google_oauth2]

  validates :username, length: {minimum: 4 }, on: :update
  validates :timezone, presence: true

  before_save :set_time_zone

  has_many :posts, dependent: :destroy

  has_many :publication_users
  has_many :publications, through: :publication_users

  has_many :received_follows, as: :followable, class_name: "Follow"
  has_many :followers, through: :received_follows, source: :user

  has_many :given_follows, class_name: "Follow"

  has_many :followed_users, through: :given_follows, source: :followable, source_type: 'User', class_name: 'User'  
  has_many :followed_publications, through: :given_follows, source: :followable, source_type: 'Publication', class_name: 'Publication'
  
  has_many :notifications

  has_many :comments

  # notification preference stored as enum
  enum notifications_freq: { instantly: 0, daily: 1, weekly: 2, off: 3  }, _suffix: :notifications

  enum new_article_notifications_freq: { daily: 0, weekly: 1, off: 2}, _suffix: :new_article_notifications

  enum performance_notifications_freq: { daily: 0, weekly: 1, off: 2}, _suffix: :performance_notifications

  
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name # assuming the user model has a name
      user.avatar_url = auth.info.image # assuming the user model has an image

      user.skip_confirmation!
    end
  end

  def following
    followed_users + followed_publications
  end

  def onboarded?
    username.present?
  end

  def published_posts
    posts.published
  end

  def draft_posts
    posts.draft
  end

  def publications_as_editor
    publications.where(publication_users: { role: "editor" })
  end
  
  
  def publications_as_admin
    publications.where(publication_users: { role: "admin" })
  end

  def pending_invite?
    invitation_created_at.present? && invitation_sent_at.blank? 
  end

  def pending_acceptance?
    invitation_created_at.present? && invitation_accepted_at.blank?
  end

  def visited_posts
    post_ids = Ahoy::Event.where(user_id: 2 , name: "post viewed").order(time: :desc).pluck(Arel.sql("properties ->> 'post_id'"))
    Post.with_discarded.where(id: post_ids).where(discarded_at: nil)
  end

  def get_views(start_time)
    post_ids = posts.published.pluck(:id)
    end_time = Time.now

    result = ActiveRecord::Base.connection.execute("
              SELECT properties->>'post_id' AS post_id, COUNT(*) AS visit_count
              FROM ahoy_events
              WHERE name = 'post viewed'
                AND properties->>'post_id' IN ('1', '2', '3')
                AND time BETWEEN '#{start_time}' AND '#{end_time}'
              GROUP BY properties->>'post_id'
            ")

    @post_views = {}

    result.values.each do |row|
      @post_views[row[0]] = row[1]
    end
    
    @post_views
  end

  private

  def set_time_zone
    self.timezone = Time.zone.name

  end
  
end
