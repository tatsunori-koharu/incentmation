require 'rails_helper'

RSpec.describe "ArticleComments", type: :system do
  before do
    @article = FactoryBot.create(:article)
    @article_comment = Faker::Lorem.sentence
  end

  it 'ログインしたユーザーは詳細ページでコメントできる' do
    # Basic認証をする
    basic_pass(path)
    visit root_path
    # ログインする
    sign_in(@article.user)
    # article詳細ページへ遷移する
    visit article_path(@article)
    # フォームに入力する
    fill_in 'article_comment_comment', with: @article_comment
    # コメントを送信すると、commentモデルのカウントが１上がる事を確認する
    expect do
      click_button "コメントする"
    end.to change(ArticleComment, :count).by(1)
    # 詳細ページにリダイレクトされる事を確認する
    expect(current_path).to eq article_path(@article)
    # 詳細ページにコメントの内容が反映されている事を確認する
    expect(page).to have_content @article_comment
  end

end
