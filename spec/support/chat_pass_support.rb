module ChatPassSupport
  def chat_pass
    click_on('チャット')
    select @user2.nickname
    click_on('チャット開始')
    expect(page).to have_content(@user2.nickname)
  end
end