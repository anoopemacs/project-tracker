json.extract! @task, :id, :author_id, :project_id, :title, :body, :status
json.owner_name @owner_name
json.project_title @project_title
json.assignments @assignments
json.comments @comments

