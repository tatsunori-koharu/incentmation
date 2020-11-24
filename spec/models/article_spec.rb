require 'rails_helper'

RSpec.describe Article, type: :model do
  before do
    @article = FactoryBot.build(:article)
  end

  describe "article登録" do
    context "articleの登録ができる" do
      it "titleとcontentを入力すれば登録できる" do
        expect(@article).to be_valid
      end
    end
    context "articleの登録ができない" do
      it "titleが空では登録できない" do
        @article.title = nil
        @article.valid?
        expect(@article.errors.full_messages).to include("Title can't be blank")
      end
      it "titleが41字以上だと登録できない" do
        @article.title = "a" * 41
        @article.valid?
        expect(@article.errors.full_messages).to include("Title is too long (maximum is 40 characters)")
      end
      it "contentが空では登録できない" do
        @article.content = nil
        @article.valid?
        expect(@article.errors.full_messages).to include("Content can't be blank")
      end
    end
  end
end
