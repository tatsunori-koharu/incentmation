require 'rails_helper'

RSpec.describe "CousultationComments", type: :system do
  before do
    @consultation = FactoryBot.create(:consultation)
    @consultation_comment = Faker::Lorem.sentence
  end

  it 'ログインしたユーザーは詳細ページでコメントできる' do
    # Basic認証をする
    basic_pass(path)
    visit root_path
    # ログインする
    sign_in(@consultation.user)
    # consultation詳細ページへ遷移する
    visit consultation_path(@consultation)
    # フォームに入力する
    fill_in 'consultation_comment_comment', with: @consultation_comment
    # コメントを送信すると、commentモデルのカウントが１上がる事を確認する
    expect do
      click_button "コメントする"
    end.to change(ConsultationComment, :count).by(1)
    # 詳細ページにリダイレクトされる事を確認する
    expect(current_path).to eq consultation_path(@consultation)
    # 詳細ページにコメントの内容が反映されている事を確認する
    expect(page).to have_content @consultation_comment
  end
end
