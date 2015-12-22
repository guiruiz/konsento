class SubscriptionsController < ApplicationController
  before_action :set_subscription, only: [:show, :edit, :update, :destroy]

  # GET /subscriptions/1
  def show
  end

  # POST /subscriptions
  def create
    @subscription = Subscription.new(subscription_params)
    @subscription.role = 'default'
    if @subscription.save
      redirect_to @subscription.group, notice: 'Subscription was successfully created.'
    else
      redirect_to controller: 'requirement_values', action: 'new', group_id: @subscription.group.id, user_id: @subscription.user.id
    end
  end

  # DELETE /subscriptions/1
  def destroy
    @subscription.destroy
    redirect_to @subscription.group, notice: 'Subscription was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subscription
      @subscription = Subscription.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def subscription_params
      params.require(:subscription).permit(:user_id, :group_id)
    end
end
