class TestsController < Simpler::Controller

  def index
    render plain: "Plain text response"
    # render 'tests/list'
    # @tests = Test.all
  end

  def create

  end

end
