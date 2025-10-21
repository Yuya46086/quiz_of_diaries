# テーブル設計

## users テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| username           | string | null: false |
| encrypted_password | string | null: false |

### Association
- has_many :posts
- has_many :daily_quizzes
- has_many :quiz_attempts


## posts テーブル
| Column     | Type       | Options                        |
| ---------- | ---------- | ------------------------------ |
| user       | references | null: false, foreign_key: true |
| content    | text       | null: false                    |
| image_url  | string     | null: false                    |
| post_date  | date       | null: false                    |

### Association
- has_one :daily_quiz
- belongs_to :user


## daily_quizzes テーブル
| Column         | Type       | Options                                      |
| -------------- | ---------- | -------------------------------------------- |
| user           | references | null: false, foreign_key: true               |
| post           | references | null: false, foreign_key: true, unique: true |
| question_text  | text       | null: false                                  |
| correct_answer | string     | null: false                                  |

### Association
- has_many :quiz_attempts
- belongs_to :user
- belongs_to :post


## quiz_attempts テーブル
| Column         | Type       | Options                        |
| -------------- | ---------- | ------------------------------ |
| user           | references | null: false, foreign_key: true |
| daily_quiz     | references | null: false, foreign_key: true |
| is_correct     | boolean    | null: false                    |
| attempt_date   | date       | null: false                    |
| question_order | integer    | null: false                    |

### Association
- belongs_to :user
- belongs_to :daily_quiz