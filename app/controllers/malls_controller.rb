class MallsController < ApplicationController

  def index
    @malls = policy_scope(Mall)
  end

  def new
    @mall = Mall.new
    @contact = @mall.build_contact
    @phone = @contact.phones.build
    authorize @mall
  end

end
