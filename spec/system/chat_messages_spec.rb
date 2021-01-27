require 'rails_helper'

RSpec.describe "ChatMessages", type: :system do
  before do
    @user1 = FactoryBot.create(:user)
    @user2 = FactoryBot.create(:user)
    @chat_message = Faker::Lorem.sentence
  end
  context 'チャットでメッセージを送れる' do
    it 'ログインユーザーはチャットでメッセージを送れる' do
      # Basic認証をする
      basic_pass(path)
      visit root_path
      # ログインする
      sign_in(@user1)
      # チャットへ遷移する
      chat_pass
      # メッセージを入力する
      fill_in 'content', with: @chat_message
      # メッセージを送るとモデルカウントが１上がる
      expect do
        click_button "送る"
      end.to change(ChatMessage, :count).by(1)
      # 送ったメッセージが存在している事を確認する
      expect(page).to have_content(@chat_message)
    end
  end
  
end
