class PurchaseController < ApplicationController
  def create
    begin
      user = User.find(params[:user_id])
    rescue ActiveRecord::RecordNotFound
      return render json: { error: "Unauthorized" }, status: :unauthorized
    end

    begin
      purchase_option = PurchaseOption.find_by!(content_id: params[:content_id], quality: params[:quality])
    rescue ActiveRecord::RecordNotFound
      return render json: { error: "Purchase Option not available" }, status: :not_found
    end

    attributes = { purchase_option: purchase_option, user: user }
    # A user can't have the same purchase active twice
    if Purchase.active.where(attributes).any?
      render json: { error: "Forbidden" }, status: :forbidden
    else
      Purchase.create! attributes
      render json: { success: true }
    end
  end
end
