class Js::ProposalsController < ApplicationController
  before_action :set_proposal

  def comments
    @comment = Comment.new(commentable: @proposal, user: current_user)
  end

  def agree
    @proposal.vote_agree(current_user)
  end

  def abstain
    @proposal.vote_abstain(current_user)
  end

  def disagree
    @proposal.vote_disagree(current_user)
  end

  def children
  end

  def propose
    @new_proposal = @proposal.dup
    @new_proposal.user = current_user
    @new_proposal.parent = @proposal
  end

  private
  def set_proposal
    @proposal = Proposal.find(params[:id])
  end
end
