# coding: utf-8
require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  # 空の値のチェック
  test "presence" do
    article = Article.new
    assert article.invalid?
    assert article.errors.include?(:title)
    assert article.errors.include?(:body)
    assert article.errors.include?(:released_at)
  end

  # 長さのチェック
  test "length" do
    article = Factory.build(:article)
    article.title = "A" * 201
    assert article.invalid?
    assert article.errors.include?(:title)
  end

  # 掲載終了日時は掲載開始日時より後
  test "expired_at" do
    article = Factory.build(:article)
    article.released_at = Time.current
    article.expired_at = 1.days.ago
    assert article.invalid?
    assert article.errors.include?(:expired_at)
  end

  # no_expirationがオンならexpired_atを使わない
  test "no_expiration" do
    article = Factory.build(:article)
    article.no_expiration = true
    assert article.valid?
    assert_nil article.expired_at
  end

  # readable_forスコープのチェック
  test "readable_for" do
    article1 = Factory(:article, title: "現在",
      released_at: 1.days.ago, expired_at: 1.days.from_now)
    article2 = Factory(:article, title: "過去",
      released_at: 2.days.ago, expired_at: 1.days.ago)
    article3 = Factory(:article, title: "未来",
      released_at: 1.days.from_now, expired_at: 2.days.from_now)
    article4 = Factory(:article, title: "終了日なし",
      released_at: 1.days.ago, expired_at: nil)
    article5 = Factory(:article, title: "会員のみ",
      released_at: 1.days.ago, expired_at: nil, member_only: true)
    
    articles = Article.readable_for(nil)
    assert_includes articles, article1, "現在の記事が含まれる"
    assert_not_includes articles, article2, "過去の記事は含まれない"
    assert_not_includes articles, article3, "未来の記事は含まれない"
    assert_includes articles, article4, "expiredがnilの場合"
    assert_not_includes articles, article5, "会員のみ"
  end
end
