# coding: utf-8

class Admin::MembersController < Admin::Base
  # 会員一覧
  def index
    @members = Member.order("number").
      paginate(page: params[:page], per_page: 15)
  end

  # 検索
  def search
    @members = Member.search(params[:q]).
      paginate(page: params[:page], per_page: 15)
    render "index"
  end

  # 会員情報の詳細
  def show
    @member = Member.find(params[:id])
  end

  # 新規作成フォーム
  def new
    @member = Member.new(birthday: Date.new(1980, 1, 1))
    @member.build_image
  end

  # 更新フォーム
  def edit
    @member = Member.find(params[:id])
    @member.build_image unless @member.image
  end

  # 会員の新規登録
  def create
    @member = Member.new(params[:member], as: :admin)
    if @member.save
      redirect_to [:admin, @member], notice: "会員を登録しました。"
    else
      render "new"
    end
  end

  # 会員情報の更新
  def update
    @member = Member.find(params[:id])
    @member.assign_attributes(params[:member], as: :admin)
    if @member.save
      redirect_to [:admin, @member], notice: "会員情報を更新しました。"
    else
      render "edit"
    end
  end

  # 会員の削除
  def destroy
    @member = Member.find(params[:id])
    @member.destroy
    redirect_to :admin_members, notice: "会員を削除しました。"
  end
end
