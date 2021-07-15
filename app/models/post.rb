class Post < ApplicationRecord
    mount_uploaders :avatars, AvatarUploader
    serialize :avatars, JSON # If you use SQLite, add this line.
end
