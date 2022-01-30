namespace :dev do
  DEFAULT_PASSWORD = 123456
  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do
    if(Rails.env.development?)
      show_spinner ("Cleaning DB...") { %x(rails db:drop) }
      show_spinner ("Creating DB...") { %x(rails db:create) }
      show_spinner ("Migrating DB...") { %x(rails db:migrate) }
      show_spinner ("Adding users...") { %x(rails dev:add_users) }
    else
      puts "Você não está em ambiente de desenvolvimento!"
    end
  end
  desc "Adiciona o administrador padrão"
  task add_user: :environment do
    User.create!(
      email: 'admin@admin.com',
      password: DEFAULT_PASSWORD,
      password_confirmation: DEFAULT_PASSWORD
    )
  end


  private
  def show_spinner msg_start, msg_end = "Success!"
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}", format: :pulse_2)
    spinner.auto_spin
    yield
    spinner.success "(#{msg_end})"
  end
end
