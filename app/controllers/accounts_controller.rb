# coding: utf-8
class AccountsController < ApplicationController
  before_filter :login_required

  def show
    @member = @current_member
  end

  def edit
    @member = @current_member
    @member.build_image unless @member.image
  end

  def update
    @member = @current_member
    @member.assign_attributes(params[:member])
    if @member.save
      redirect_to :account, notice: "アカウント情報を更新しました。"
    else
      render "edit"
    end
  end
end
