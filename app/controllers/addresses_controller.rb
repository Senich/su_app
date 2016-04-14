class AddressesController < ApplicationController

  def index
    @addresses = policy_scope(Address)
  end

  def new
    @address = Address.new
    authorize @address
  end

end
