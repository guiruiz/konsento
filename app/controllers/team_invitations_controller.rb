class TeamInvitationsController < ApplicationController
  before_action :require_login, only: [:create, :accept]

  def create
    team = Team.find(team_invitation_params[:team_id])
    TeamInvitation.invite_emails(team_invitation_params[:email], team, current_user)
    redirect_to invitations_team_path(team)
  end

  def accept
    @team_invitation = TeamInvitation.find_by(token: params[:token])
    @subscription = Subscription.new(user: current_user, subscriptable: @team_invitation.team)
    add_breadcrumb TeamInvitation.model_name.human
  end

  private

  def team_invitation_params
    params.require(:team_invitation).permit(:team_id, :email)
  end
end
