require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  before do
    FactoryBot.create(:task)
    FactoryBot.create(:second_task)
  end  
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in "task[name]", with: "task"
        fill_in "task[description]", with: "task_leaf"
        select '2022',from: 'task[expiry_date(1i)]'
        select '11',from: 'task[expiry_date(2i)]'
        select '1',from: 'task[expiry_date(3i)]'
        click_on "登録する"
        expect(page).to have_content 'task'
      end
    end
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        visit tasks_path
        expect(page).to have_content 'test_name1'
      end
    end
    context 'タスクが作成日時も降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        FactoryBot.create(:task, name: '最新task')
        visit tasks_path
        task_list = all('.task_row')
        expect(task_list[0]).to have_content '最新task'
      end
    end
    context '終了期限でソートする場合' do
      it '終了期限の降順に並び替えられたタスク一覧が表示される' do
        FactoryBot.create(:task, name: '年末task', expiry_date: '2022/12/31')
        FactoryBot.create(:task, name: '師走頭task', expiry_date: '2022/12/01')
        visit tasks_path
        click_on "終了期限"
        task_list = all('.task_row')
        # save_and_open_page
        expect(task_list[0]).to have_content '年末task'
      end
    end  
  end
  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        task = FactoryBot.create(:task)
        visit task_path(task.id)
        expect(page).to have_content 'test_name1'
      end
    end
  end
end