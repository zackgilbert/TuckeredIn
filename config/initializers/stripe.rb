# defaults to test key/secret
Rails.configuration.stripe = {
  :publishable_key => ENV['PUBLISHABLE_KEY'] || "pk_test_U8PJlXcckz6yt0bDRyJlvRZd",
  :secret_key      => ENV['SECRET_KEY'] || "sk_test_TMbSrvlENhzRXmduSlUpsMyD"
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]
