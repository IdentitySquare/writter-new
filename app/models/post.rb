# == Schema Information
#
# Table name: posts
#
#  id              :bigint           not null, primary key
#  discarded_at    :datetime
#  draft_body      :string
#  draft_title     :string
#  published_at    :datetime
#  published_title :string
#  status          :integer          default("draft"), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  publication_id  :bigint
#  user_id         :bigint           not null
#
# Indexes
#
#  index_posts_on_discarded_at    (discarded_at)
#  index_posts_on_publication_id  (publication_id)
#  index_posts_on_user_id         (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (publication_id => publications.id)
#  fk_rails_...  (user_id => users.id)
#
class Post < ApplicationRecord
  include ActionView::Helpers::SanitizeHelper
  include Notifiable
  #----- CONSTANTS -----#
  enum status: { draft: 0, published: 1 }
  
   #----- ASSOCIATIONS -----#

  belongs_to :user
  belongs_to :publication, optional: true
  has_many :comments, dependent: :destroy

  has_rich_text :draft_body
  has_rich_text :published_body

  has_paper_trail

  #callback if saved change to publication_id
  after_update :create_notification!, if: -> { saved_change_to_publication_id? }

  include Discard::Model
  default_scope -> { kept }
  def create_notification!
    changed_by = User.find(versions[-1].whodunnit)
    if changed_by != user
      Notification.create(user: user, sender: changed_by, notifiable: self, notification_type: 'post_removed_from_publication')
    end
  end


  def empty?
    rich_text_draft_body.nil? && draft_title.nil?
  end


  def views(range = Time.at(0))
    page_views = Ahoy::Event.where(name: 'post viewed')
                            .where(properties: { post_id: id })
                            .where(time: range..Time.now)
                            .count
  end


end
