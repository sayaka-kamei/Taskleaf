require 'rails_helper'
RSpec.describe 'ユーザー管理機能', type: :system do
  describe do
    describe 'ユーザー登録テスト' do
      context 'ユーザー新規登録した場合' do
        it '作成したタスクが表示される' do
          visit new_user_path
          fill_in "user[name]", with: "test_name1"
          fill_in "user[email]", with: "test1@gmail.com"
          fill_in "user[password]", with: "test_test"
          fill_in "user[password_confirmation]", with: "test_test"
          click_on "登録する"
          expect(page).to have_content 'ログイン'
        end
      end
      context 'ユーザがログインせずタスク一覧画面に飛ぼうとした場合' do
        it 'ログイン画面に遷移する' do
          visit new_user_path
          fill_in "user[name]", with: "test_name1"
          fill_in "user[email]", with: "test1@gmail.com"
          fill_in "user[password]", with: "test_test"
          fill_in "user[password_confirmation]", with: "test_test"
          click_on "登録する"
          visit tasks_path
          expect(page).to have_content 'ログイン'
        end
      end 
    end
    describe 'セッション機能' do
      let!(:user){ FactoryBot.create(:user)}
      let!(:second_user){ FactoryBot.create(:second_user)}
      context 'ユーザーがログインする場合' do
        before do
          visit new_session_path
          fill_in "session[email]", with: user.email
          fill_in "session[password]", with: user.password
          click_on "ログインする"
        end  
        it 'ログインができる' do
          expect(page).to have_content 'ページ'
        end
        it '詳細画面が表示される' do
          expect(page).to have_content 'name1'
        end
        it 'タスク一覧に遷移する' do
          visit user_path(5)
          expect(page).to have_content 'タスク一覧'
        end
        it 'ログアウトするとログイン画面に遷移する' do
          visit tasks_path
          click_on 'Logout'
          expect(page).to have_content 'ログアウトしました'
        end
      end
    end   
    describe '管理画面機能' do
      context '管理ユーザがログインした場合' do
        it '管理画面にアクセスできる' do
          FactoryBot.create(:user)
          visit new_session_path
          fill_in 'session[email]', with: "email1@gmail.com"
          fill_in 'session[password]', with: "password1"
          click_on "ログインする"
          click_on 'ユーザー一覧'
          expect(page).to have_content 'ユーザー 一覧'
        end
      end
      context '一般ユーザがログインした場合' do
        it '管理画面にアクセスできない' do
          FactoryBot.create(:second_user)
          visit new_session_path
          fill_in 'session[email]', with: "email2@gmail.com"
          fill_in 'session[password]', with: "password2"
          click_on "ログインする"
          visit admin_users_path
          expect(page).to have_content 'タスク一覧'
        end
      end
      context '管理ユーザがユーザの新規登録する場合' do
        it '新規登録ができる' do
          FactoryBot.create(:user)
          visit new_session_path
          fill_in 'session[email]', with: "email1@gmail.com"
          fill_in 'session[password]', with: "password1"
          click_on "ログインする"
          click_on 'ユーザー一覧'
          click_on '新規登録'
          fill_in "user[name]", with: "test_name1"
          fill_in "user[email]", with: "test1@gmail.com"
          fill_in "user[password]", with: "test_test"
          fill_in "user[password_confirmation]", with: "test_test"
          click_on "登録する"
          expect(page).to have_content 'ユーザー 一覧'
        end
      end
      context '管理ユーザがログインした場合' do
        it '詳細画面にアクセスできる' do
          FactoryBot.create(:user)
          visit new_session_path
          fill_in 'session[email]', with: "email1@gmail.com"
          fill_in 'session[password]', with: "password1"
          click_on "ログインする"
          click_on 'ユーザー一覧'
          click_on '詳細'
          expect(page).to have_content 'name1'
        end
      end
      context '管理ユーザが編集画面にアクセスした場合' do
        it '編集できる' do
          FactoryBot.create(:user)
          visit new_session_path
          fill_in 'session[email]', with: "email1@gmail.com"
          fill_in 'session[password]', with: "password1"
          click_on "ログインする"
          click_on "ユーザー一覧"
          click_on '編集'
          fill_in "user[password]", with: "test_test"
          fill_in "user[password_confirmation]", with: "test_test"
          click_on "登録する"
          expect(page).to have_content 'name1'
        end
      end
      context '管理ユーザがログインした場合' do
        it '管理画面にアクセスできる' do
          FactoryBot.create(:user)
          visit new_session_path
          fill_in 'session[email]', with: "email1@gmail.com"
          fill_in 'session[password]', with: "password1"
          click_on "ログインする"
          click_on 'ユーザー一覧'
          click_on '削除'
          expect(page).to have_content '削除しました'
        end
      end
    end
  end    
end  