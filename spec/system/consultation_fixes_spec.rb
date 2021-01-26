require 'rails_helper'

RSpec.describe "CousultationFixes", type: :system do
  before do
    @consultation = FactoryBot.create(:consultation)
  end

  it 'ログインしたユーザーは詳細ページでコメントできる' do
    # Basic認証をする
    basic_pass(path)
    visit root_path
    # ログインする
    sign_in(@consultation.user)
    # consultation詳細ページへ遷移する
    visit consultation_path(@consultation)
    # Goodボタンをクリックする
    find('.unsol').click
    expect(page.find('.sol')).to have_content("解決")
    find('.sol').click
    expect(page.find('.unsol')).to have_content("未解決")
  end
end
