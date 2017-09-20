if defined?(Bullet)
  Rails.application.config.after_initialize do
    Bullet.enable = true
    Bullet.unused_eager_loading_enable = true
    Bullet.alert = true
  end
end
