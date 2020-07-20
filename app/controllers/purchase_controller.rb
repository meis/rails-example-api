class PurchaseController < ApplicationController
  def index
    begin
      user = User.find(params[:user_id])
    rescue ActiveRecord::RecordNotFound
      return render json: { error: "Unauthorized" }, status: :unauthorized
    end

    purchases = Purchase
      .active
      .where(user: user)
      .eager_load(:purchase_option, :content)
      .order(expiry_date: :asc)

    render json: { size: purchases.size, items: purchases.map { |p| serialize_purchase(p) } }
  end

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

  private

  def serialize_purchase(purchase)
    {
      expiryDate: purchase.expiry_date,
      quality: purchase.purchase_option.quality,
      content: {
        id: purchase.content.id,
        type: purchase.content.content_type,
        title: purchase.content.title,
        plot: purchase.content.plot,
      }
    }
  end
end
