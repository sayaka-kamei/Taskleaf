require 'rails_helper'
RSpec.describe 'ラベル管理機能', type: :system do
  let!(:user){ FactoryBot.create(:user)}
  let!(:task){ FactoryBot.create(:label) }
  describe do
    before do
      visit new_session_path
      fill_in "session[email]", with: user.email # 'email1@gmail.com'
      fill_in "session[password]", with: user.password # 'password1'
      click_button 'ログインする'
    end
    describe '新規作成機能' do
      context 'タスクを新規作成した場合' do
        it '作成したラベルが表示される' do
          visit new_task_path
          fill_in "task[name]", with: "task"
          fill_in "task[description]", with: "task_leaf"
          select '2022',from: 'task[expiry_date(1i)]'
          select '11',from: 'task[expiry_date(2i)]'
          select '1',from: 'task[expiry_date(3i)]'
          select '完了',from: 'task[status]'
          select '高',from: 'task[priority]'
          check "task[label_ids][]"
          click_on "登録する"
          expect(page).to have_content 'sample1'
        end
        it '作成したラベルが検索できる' do
          visit tasks_path
          select 'sample1',from: 'task_label_id'
          click_on "検索する"
          expect(page).to have_content 'sample1'
        end  
      end
    end      
  end
end    