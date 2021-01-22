require 'rails_helper'

RSpec.describe "Users", type: :system do
  before do
    @user = FactoryBot.build(:user)
  end
  context 'ユーザー新規登録ができるとき' do
    it '正しい情報を入力すればユーザー新規登録ができてトップページに移動する' do
    # Basik認証を入力
    fill_in 
    # トップページに移動する
    visit root_path
    # トップページにサインアップページへ遷移するボタンがあることを確認する
    expect(page).to have_content('新規登録')
    # 新規登録ページに遷移する
    visit new_user_registration_path
    # ユーザー情報を入力する
    fill_in 'Nickname', with: @user.nickname
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    fill_in 'Password Confirmation', with: @user.password_confirmation
    fill_in 'Location', with: @user.location_id
    fill_in 'Department', with: @user.department_id
    fill_in 'Ded', with: @user.bed
    fill_in 'Service Years', with: @user.service_years
    fill_in 'License', with: @user.license
    fill_in 'Company', with: @user.company
    # サインアップボタンを押すとユーザーモデルのカウントが上がることを確認する
    expect (
      find('input[name="commit"]').click
    ).to change { User.count }.by(1)
    # トップページへ遷移する
    expect(current_path).to eq root_path
    # クリックするとログアウトボタンが表示されることを確認する
    expect(
      find(".user-icon").find(".user-menu").click
    ).to have_content('ログアウト')
    # サインアップページへ遷移するボタンや、ログインページへ遷移するボタンが表示されていないことを確認する
    expect(page).to have_no_content('新規登録')
    expect(page).to have_no_content('ログイン')
    end
  end
  context 'ユーザー新規登録ができないとき' do
    it '誤った情報ではユーザー新規登録ができずに新規登録ページへ戻る' do
      # トップページに移動する
      # トップページにサインアップページへ遷移するボタンがあることを確認する
      # 新規登録ページに遷移する
      # ユーザー情報を入力する
      # サインアップボタンを押してもユーザーモデルのカウントは上がらないことを確認する
      # 新規登録ページへ戻ることを確認する
    end
  end

  pending "add some scenarios (or delete) #{__FILE__}"
end
