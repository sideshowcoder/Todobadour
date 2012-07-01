if Rails.env.development?
  FAYE_URL = "http://localhost:9292/faye"
else
  FAYE_URL = "http://todobadour.sideshowcoder.com:9292/faye"
end