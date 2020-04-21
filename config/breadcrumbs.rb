crumb :root do
  link "トップページ", root_path
end

crumb :category do
  link "カテゴリー", category_index_path
  parent :root
end

crumb :children do |children| 
  link category.children.name, category_path
  parent :category
end

crumb :mypage do
  link "マイページ", mypage_path(user_id: current_user.id)
  parent :root
end

crumb :mypage_exhibition do
  link "出品中の商品一覧", my_page_exhibition_mypage_path(user_id: current_user.id)
  parent :mypage
end

crumb :mypage_sold do
  link "売却済み商品一覧", my_page_transaction_mypage_path(user_id: current_user.id)
  parent :mypage
end

crumb :mypage_exhibiting do
  link "取引中商品"
  parent :mypage
end


# crumb : do
#   link "購入商品一覧", projects_path
# end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).