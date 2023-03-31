require 'rails_helper'
require 'spec_helper'

describe 'EmailingService' do

  before do

    @user = FactoryBot.create(:user, notifications: true, new_article_notifications_freq: 0)
    @user2 = FactoryBot.create(:user, notifications: true, new_article_notifications_freq: 0)

    @followed_user = FactoryBot.create(:user)

    FactoryBot.create(:follow,
      user: @user,
      followable: @followed_user)
    
    @followed_publication = FactoryBot.create(:publication)
    FactoryBot.create(:follow,
      user: @user,
      followable: @followed_publication)
  
    Timecop.freeze(2021, 9, 1, 18, 0, 0)
  end

  after do
    Timecop.return
  end

  describe 'send_new_posts_emails_at_6pm!' do
    context 'notifications on' do
      context 'when new posts exists from followed user' do
        it 'sends email when new post from follower' do
          @post = FactoryBot.create(:post, user: @followed_user, status: 1, published_at: 1.hour.ago, publication: nil)
        
          expect { EmailingService.new.send_new_posts_emails_at_6pm!(timezones: [@user.timezone]) }
            .to(
              have_enqueued_job.on_queue('default')
              .with(
                'PostsMailer',
                'daily_mail',
                'deliver_now',
                {
                  params: {
                    user_id: @user.id,
                    post_ids: @followed_user.posts.pluck(:id),
                  },
                  args: []
                }
              )
            )
        end
      end

      context 'when new posts exists from followed publication' do
        it 'sends email when new post from follower' do
          @post = FactoryBot.create(:post, publication: @followed_publication, user: @user2, status: 1, published_at: 1.hour.ago)
          
          expect { EmailingService.new.send_new_posts_emails_at_6pm!(timezones: [@user.timezone]) }
            .to(
              have_enqueued_job.on_queue('default')
              .with(
                'PostsMailer',
                'daily_mail',
                'deliver_now',
                {
                  params: {
                    user_id: @user.id,
                    post_ids: @followed_publication.posts.pluck(:id),
                  },
                  args: []
                }
              )
            )
        end
      end

      context 'when no new post exists' do
        it 'doesnt sends email' do
          @post = FactoryBot.create(:post, user: @followed_user, status: 1, published_at: 1.hour.ago)
          expect { EmailingService.new.send_new_posts_emails_at_6pm!(timezones: [@user.timezone]) }
            .to_not(
              have_enqueued_job.on_queue('default')
              .with(
                'PostsMailer',
                'weekly_mail',
                'deliver_now',
                {
                  params: {
                    user_id: @user.id,
                    post_ids: @followed_user.posts.pluck(:id),
                  },
                  args: []
                }
              )
            )
        end
      end

      
    end
    
    context 'notifications off' do
      it 'doesnt send email when new post from follower' do
        @user.update(email_notifications: true)
        @user.update(new_article_notifications_freq: 2)
        @post = FactoryBot.create(:post, user: @followed_user, status: 1, published_at: 1.hour.ago)
        expect { EmailingService.new.send_new_posts_emails_at_6pm!(timezones: [@user.timezone]) }
        .to_not(
            have_enqueued_job.on_queue('default')
            .with(
              'PostsMailer',
              'weekly_mail',
              'deliver_now',
              {
                params: {
                  user_id: @user.id,
                  post_ids: @followed_user.posts.pluck(:id),
                },
                args: []
              }
            )
          )
      end
      
    end


    context 'main email notifications off' do
      it 'doesnt send email when new post from follower' do
        @user.update(email_notifications: false)
        @user.update(new_article_notifications_freq: 1)
        @post = FactoryBot.create(:post, user: @followed_user, status: 1, published_at: 1.hour.ago)
        expect { EmailingService.new.send_new_posts_emails_at_6pm!(timezones: [@user.timezone]) }
        .to_not(
            have_enqueued_job.on_queue('default')
            .with(
              'PostsMailer',
              'weekly_mail',
              'deliver_now',
              {
                params: {
                  user_id: @user.id,
                  post_ids: @followed_user.posts.pluck(:id),
                },
                args: []
              }
            )
          )
      end
      
    end
    
   
  end
end