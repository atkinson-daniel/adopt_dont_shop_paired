class ChangeDefaultPhotoInReviews < ActiveRecord::Migration[5.1]
  def change
    change_column :reviews, :picture, :string, default: "https://i0.wp.com/happening-news.com/wp-content/uploads/2019/04/Screen-Shot-2019-04-09-at-2.57.27-PM.png?resize=543%2C531&ssl=1"
  end
end
