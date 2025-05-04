# frozen_string_literal: true

# HelloJob is a Sidekiq job that prints a greeting message.
class HelloJob
  include Sidekiq::Job

  def perform(name = 'World')
    puts "Hello, #{name} from Sidekiq!"
  end
end
