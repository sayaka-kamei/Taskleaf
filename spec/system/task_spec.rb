require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  before do
    FactoryBot.create(:task)
    FactoryBot.create(:second_task)
    FactoryBot.create(:third_task)
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
        select '完了',from: 'task[status]'
        select '高',from: 'task[priority]'
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
        visit tasks_path
        click_on "終了期限"
        sleep(1)
        task_list = all('.task_row')
        expect(task_list[0]).to have_content 'test_name2'
      end
    end
    context '優先順位でソートする場合' do
      it '優先順位の昇順に並び替えられたタスク一覧が表示される' do
        visit tasks_path
        click_on "優先順位"
        sleep(1)
        task_list = all('.task_row')
        # save_and_open_page
        expect(task_list[0]).to have_content 'test_name1'
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
  describe '検索機能' do
    context 'タイトルであいまい検索をした場合' do
      it "検索キーワードを含むタスクで絞り込まれる" do
        visit tasks_path
        fill_in "task[name]", with: "name1"
        click_on "検索する"
        expect(page).to have_content 'test_name1'
      end
    end
    context 'ステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        visit tasks_path
        select "着手", from: 'task[status]'
        click_on "検索する"
        expect(page).to have_content '着手'
      end
    end
    context 'タイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        visit tasks_path
        fill_in "task[name]", with: "name1"
        select "着手", from: 'task[status]'
        click_on "検索する"
        # save_and_open_page
        expect(page).to have_content "name1"
        expect(page).to have_content '着手'
      end
    end
  end  
end