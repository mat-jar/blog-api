class Api::V1::MessageStorageController < ApplicationController

  def list
    @messages = MessageStorage.list
    render json: @messages
  end

end
