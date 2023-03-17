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
#  new_article_notifications_freq :integer          default(0)
#  notifications                  :boolean          default(TRUE)
#  notifications_freq             :integer          default(0)
#  performance_notifications_freq :integer          default(0)
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
require "test_helper"

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
