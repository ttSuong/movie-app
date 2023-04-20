module Users
  class CreateSession
    prepend SimpleCommand
    def initialize(params)
      @params = params
    end

    def call
      Movie.create(@params)
    end
  end
end