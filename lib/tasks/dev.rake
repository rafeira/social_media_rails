# frozen_string_literal: true

include FactoryBot::Syntax::Methods

namespace :dev do
  DEFAULT_PASSWORD = 123_456
  desc 'Configura o ambiente de desenvolvimento'
  task setup: :environment do
    if Rails.env.development?
      show_spinner('Cleaning DB...') { `rails db:drop` }
      show_spinner('Creating DB...') { `rails db:create` }
      show_spinner('Migrating DB...') { `rails db:migrate` }
      show_spinner('Adding default users...') { `rails dev:add_default_users` }
      show_spinner('Adding users...') { `rails dev:add_users` }
      show_spinner('Add posts to users...') { `rails dev:add_posts_to_users` }
      show_spinner('Add comments to posts...') { `rails dev:add_comments_to_posts` }
      show_spinner('Add likes to likeable...') { `rails dev:add_likes_to_likeable` }
    else
      puts 'Você não está em ambiente de desenvolvimento!'
    end
  end

  desc 'Adiciona usuários padrão'
  task add_default_users: :environment do
    create(:user, password: DEFAULT_PASSWORD, email: 'user@user.com')
    create(:user, password: DEFAULT_PASSWORD, email: 'rafeira@user.com')
  end

  desc 'Adiciona usuários'
  task add_users: :environment do
    create_list(:user, 20)
  end

  desc 'Adiciona postagens a usuários'
  task add_posts_to_users: :environment do
    users = User.all
    users.each do |user|
      create_list(:post, rand(0..5), user: user)
    end
  end

  desc 'Adiciona comentários a postagens'
  task add_comments_to_posts: :environment do
    posts = Post.all

    posts.each do |post|
      user = User.where.not(id: post.comments.pluck(:user_id)).sample
      create_list(:comment, rand(1..4), commentable: post, user: user)
    end
  end

  desc 'Adiciona likes a comentários e postagens'
  task add_likes_to_likeable: :environment do
    likeables = [Comment.all, Post.all].flatten(1)
    likeables.each do |likeable|
      3.times do
        user = User.where.not(id: likeable.likes.pluck(:user_id)).sample
        create(:like, user: user, likeable: likeable)
      end
    end
  end

  private

  def show_spinner(msg_start, msg_end = 'Success!')
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}", format: :pulse_2)
    spinner.auto_spin
    yield
    spinner.success "(#{msg_end})"
  end
end
