require 'rails_helper'

RSpec.describe "Chats", type: :system do
  before do
    @user1 = FactoryBot.create(:user)
    @user2 = FactoryBot.create(:user)
  end
  context 'チャットルーム作成できる' do
    it 'ログインユーザーは別のユーザーとのチャットルームを作成できる' do
      # Basic認証をする
      basic_pass(path)
      visit root_path
      # ログインする
      sign_in(@user1)
      # チャットへの遷移リンクがある
      expect(page).to have_link 'チャット', href: new_chat_path
      # チャットへ遷移する
      visit new_chat_path
      # 相手を選択肢チャットルームへ遷移
      select @user2.nickname
      expect do
        click_button "チャット開始"
      end.to change(Chat, :count).by(1)
      # 選択した相手とのチャットルームである事を確認
      expect(page).to have_content(@user2.nickname)
    end
    it 'ログインしていないとチャットルームを作成できない' do
      # トップページに遷移する
      basic_pass(path)
      visit root_path
      # チャットへのリンクがない
      expect(page).to have_no_link 'チャット', href: new_chat_path
    end
  end
end
RSpec.describe "Chats_User", type: :system do
  before do
    @user1 = FactoryBot.create(:user)
    @user2 = FactoryBot.create(:user)
    @article1 = FactoryBot.create(:article)
    @article2 = FactoryBot.create(:article)
  end
  context 'ユーザー詳細ページからチャットへ遷移できる' do
    it '他ユーザーの詳細ページからチャットへ遷移できる' do
      # article1を投稿したユーザーでログインする
      basic_pass(path)
      sign_in(@article1.user)
      # article2に遷移する
      visit article_path(@article2.id)
      # 個人の詳細ページへのリンクがある事を確認する
      expect(page).to have_no_link @user2.nickname, href: users_show_path(id: @user2.id)
      # 個人の詳細ページへ遷移する
      visit users_show_path(id: @user2.id)
      # 個人のプロフィールを確認する
      find('.u_btn').click
      # チャットボタンがある事を確認する
      expect(page).to have_content("チャット")
      # チャットルームへ遷移する
      find('.chat_btn').click
      # 指定した相手とのチャットルームである事を確認する
      expect(page).to have_content(@user2.nickname)
    end
    it '自分の詳細ページからはチャットへ遷移できない' do
      # article1を投稿したユーザーでログインする
      basic_pass(path)
      sign_in(@user1)
      # 個人の詳細ページへ遷移する
      visit users_show_path(id: @user1.id)
      # 個人のプロフィールを確認する
      find('.u_btn').click
      # チャットボタンがない事を確認する
      expect(page).to have_no_content('.chat_btn')
    end
  end
end
