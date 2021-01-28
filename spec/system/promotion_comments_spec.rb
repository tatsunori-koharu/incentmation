require 'rails_helper'

RSpec.describe "PromotionComments", type: :system do
  before do
    @promotion = FactoryBot.create(:promotion)
    @promotion_comment = Faker::Lorem.sentence
  end

  it 'ログインしたユーザーは詳細ページでコメントできる' do
    # Basic認証をする
    basic_pass(path)
    visit root_path
    # ログインする
    sign_in(@promotion.user)
    # promotion詳細ページへ遷移する
    visit promotion_path(@promotion)
    # フォームに入力する
    fill_in 'promotion_comment_comment', with: @promotion_comment
    # コメントを送信すると、commentモデルのカウントが１上がる事を確認する
    expect do
      click_button "コメントする"
    end.to change(PromotionComment, :count).by(1)
    # 詳細ページにリダイレクトされる事を確認する
    expect(current_path).to eq promotion_path(@promotion)
    # 詳細ページにコメントの内容が反映されている事を確認する
    expect(page).to have_content @promotion_comment
  end
end
