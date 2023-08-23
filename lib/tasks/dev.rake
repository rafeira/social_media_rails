# frozen_string_literal: true

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
    User.create!(create_default_users)
  end

  desc 'Adiciona usuários'
  task add_users: :environment do
    User.create!(create_users)
  end

  desc 'Adiciona postagens a usuários'
  task add_posts_to_users: :environment do
    users = User.all
    users.each do |user|
      rand(0..5).times do
        user.posts.build(
          title: FFaker::Lorem.words(rand(2..5)).join(' '),
          description: FFaker::Lorem.paragraphs(rand(2..4)).join("\n")
        ).save!
      end
    end
  end

  desc 'Adiciona comentários a postagens'
  task add_comments_to_posts: :environment do
    posts = Post.all
    posts.each do |post|
      rand(1..4).times do
        post.comments.build(
          description: FFaker::Lorem.paragraphs(2).join("\n"),
          user: User.all.sample
        ).save!
      end
    end
  end

  desc 'Adiciona likes a comentários e postagens'
  task add_likes_to_likeable: :environment do
    likeables = [Post.all, Comment.all].flatten
    all_users = User.all
    likeables.each do |likeable|
      users = all_users.to_a
      3.times do
        user = users.sample
        like = likeable.likes.first_or_create user: user
        like.save
        users.delete user
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

  def create_users
    users = []
    20.times do
      users << {
        email: FFaker::Internet.email,
        first_name: FFaker::Name.first_name,
        last_name: FFaker::Name.last_name,
        password: DEFAULT_PASSWORD,
        password_confirmation: DEFAULT_PASSWORD
      }
    end
    users
  end

  def create_default_users
    [
      {
        email: 'user@user.com',
        password: DEFAULT_PASSWORD,
        first_name: FFaker::Name.first_name,
        last_name: FFaker::Name.last_name,
        password_confirmation: DEFAULT_PASSWORD
      },
      {
        email: 'rafeira@user.com',
        first_name: FFaker::Name.first_name,
        last_name: FFaker::Name.last_name,
        password: DEFAULT_PASSWORD,
        password_confirmation: DEFAULT_PASSWORD
      }
    ]
  end
end
