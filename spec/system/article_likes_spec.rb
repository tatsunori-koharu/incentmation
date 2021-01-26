require 'rails_helper'

RSpec.describe "ArticleLikes", type: :system do
  before do
    @article = FactoryBot.create(:article)

    def wait_for_ajax(wait_time = Capybara.default_max_wait_time)
      Timeout.timeout(wait_time) do
        loop until finished_all_ajax_requests?
      end
      yield if block_given?
    end

    def finished_all_ajax_requests?
      page.evaluate_script('jQuery.active').zero?
    end

  end

  it 'ログインしたユーザーは詳細ページでコメントできる' do
    # Basic認証をする
    basic_pass(path)
    visit root_path
    # ログインする
    sign_in(@article.user)
    # article詳細ページへ遷移する
    visit article_path(@article)
    # Goodボタンをクリックする
    find('.good').click
    expect(page.find('.good')['src']).to have_content("assets/good_white-e69dc9a6b50925900b6570fc1d6158f91dfc12fbb1b6d1246b5b4bc8463fc2e5.png")
    find('.good').click
    expect(page.find('.good')['src']).to have_content("assets/good_black-81b8751b505202e0bf7a40d86b7627d676a0e41ef69257b738b5beea1501a2fd.png")
  end

end
