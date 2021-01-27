require 'rails_helper'

RSpec.describe "Donkeykings", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @tweet = Faker::Lorem.sentence
  end
  context '愚痴の投稿ができる' do
    it 'ログインユーザーは愚痴の投稿ができる' do
      # Basic認証をする
      basic_pass(path)
      visit root_path
      # ログインする
      sign_in(@user)
      # 愚痴への遷移リンクがある
      expect(page).to have_link '愚痴', href: new_donkeyking_path
      # 愚痴へ遷移する
      click_on('愚痴')
      # 愚痴に遷移できたか確認する
      expect(current_path).to eq new_donkeyking_path
      # 愚痴を入力する
      fill_in 'donkeyking_tweet', with: @tweet
      # 投稿するとモデルカウントが１上がる
      expect do
        click_on('吐き出し')
      end.to change(Donkeyking, :count).by(1)
      # 投稿が反映されている事を確認する
      expect(page).to have_content(@tweet)
    end
  end
  context '愚痴の投稿ができない' do
    it 'ログインしなければ愚痴が投稿できない' do
      # トップページへ遷移する
      basic_pass(path)
      visit root_path
      # 愚痴へのリンクがない事を確認する
      expect(page).to have_no_link '愚痴', href: new_donkeyking_path
    end
  end
end
