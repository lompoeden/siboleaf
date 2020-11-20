## Task model
| Column name | Data type |
|:------------|:-----------|
| title       | string     |
| content     | text       |
| startdate   | datetime   |
| status      | string     |
| priority    | integer    |
| user_id       | integer  |
## User model
| Column name | Data type     |
|:------------|:--------------|
| name        | string        |
| email       | string        |
| password_digest | string    |
## Label model
| Column name | Data type |
|:------------|:-----------|
| name       | string     |

##  Bag label model
| Column name | Data type |
|:------------|:----------|
| task_id     | integer   |
| label_id    | integer   |
***

1. Login

. To create an app on heroku you need to login first by using the command below heroku login

Then the following instructions

2. To create an app on heroku use the command below heroku create

3. To push the codes on heroku use the command below and make sure the branch is master git push heroku master

4. To perform migrations on heroku use the command below heroku run rails detached db:migrate
