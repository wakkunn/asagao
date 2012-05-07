# coding: utf-8

class EntriesController < ApplicationController
  before_filter :login_required, except: [:index, :show]

  # 記事一覧
  def index
    if params[:member_id]
      @member = Member.find(params[:member_id])
      rel = @member.entries
    else
      rel = Entry
    end
    @entries = rel.readable_for(@current_member).
                 order("posted_at DESC").
                 paginate(page: params[:page], per_page: 5)
  end

  # 記事詳細
  def show
    @entry = Entry.readable_for(@current_member).find(params[:id])
  end

  # 新規登録フォーム
  def new
    @entry = Entry.new(posted_at: Time.current)
  end

  # 編集フォーム
  def edit
    @entry = @current_member.entries.find(params[:id])
  end

  # 新規作成
  def create
    @entry = Entry.new(params[:entry])
    @entry.author = @current_member
    if @entry.save
      redirect_to @entry, notice: "記事を作成しました。"
    else
      render "new"
    end
  end

  # 更新
  def update
    @entry = @current_member.entries.find(params[:id])
    @entry.assign_attributes(params[:entry])
    if @entry.save
      redirect_to @entry, notice: "記事を更新しました。"
    else
      render "edit"
    end
  end

  # 削除
  def destroy
    @entry = @current_member.entries.find(params[:id])
    @entry.destroy
    redirect_to [@current_member, :entries],
      notice: "記事を削除しました。"
  end

  # 投票
  def like
    @entry = Entry.published.find(params[:id])
    @current_member.voted_entries << @entry
    redirect_to @entry, notice: "投票しました。"
  end

  # 投票した記事
  def voted
   @entries = @current_member.voted_entries.published.
                order("votes.created_at DESC").
                paginate(page: params[:page], per_page: 15)
  end

  # 投票削除
  def unlike
    @current_member.voted_entries.delete(Entry.find(params[:id]))
    redirect_to :voted_entries, notice: "削除しました。"
  end
end
