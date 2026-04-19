source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "~> 3.3"

# ── Core ─────────────────────────────────────────────────────
gem "rails", "~> 7.1.6"
gem "pg", "~> 1.5"                        # PostgreSQL
gem "puma", "~> 6.4"                      # App server
gem "bootsnap", require: false            # Faster boot times

# ── Auth ─────────────────────────────────────────────────────
gem "devise", "~> 4.9"                    # Authentication
gem "pundit", "~> 2.3"                    # Authorization / policies

# ── Multi-tenancy ─────────────────────────────────────────────
gem "acts_as_tenant", "~> 0.6"           # Scopes all queries to Account

# ── State Machines ───────────────────────────────────────────
gem "aasm", "~> 5.5"                      # State machines for applications & privileges

# ── Background Jobs ──────────────────────────────────────────
gem "sidekiq", "~> 7.2"                   # Background job processing
gem "sidekiq-scheduler", "~> 5.0"        # Cron-style jobs (expiry reminders etc.)

# ── Frontend ─────────────────────────────────────────────────
gem "importmap-rails"                     # JS via import maps (no Node required)
gem "turbo-rails"                         # Hotwire Turbo
gem "stimulus-rails"                      # Hotwire Stimulus
gem "tailwindcss-rails"                   # Tailwind CSS

# ── Views ────────────────────────────────────────────────────
gem "view_component", "~> 3.9"           # Component-based views
gem "pagy", "~> 8.4"                     # Fast pagination

# ── Forms ────────────────────────────────────────────────────
gem "simple_form", "~> 5.3"              # Form builder (pairs well with Tailwind)

# ── File Storage ─────────────────────────────────────────────
gem "aws-sdk-s3", require: false          # Active Storage → S3 (credentialing docs)

# ── Billing ──────────────────────────────────────────────────
gem "pay", "~> 7.2"                       # Stripe/billing abstraction (Stripe, Lemon Squeezy)
gem "stripe", "~> 12.0"

# ── Notifications ────────────────────────────────────────────
gem "noticed", "~> 2.3"                  # Notification system (expiry alerts, review events)

# ── Misc Utilities ───────────────────────────────────────────
gem "interactor", "~> 3.1"               # Service objects / interactors
gem "dry-validation", "~> 1.10"          # Schema validation (CAQH imports etc.)
gem "phonelib"                            # Phone number validation
gem "validates_zipcode"                   # US zip code validation
gem "money-rails", "~> 1.15"            # If you ever surface pricing/fees

group :development, :test do
  gem "debug", platforms: %i[mri mingw x64_mingw]
  gem "rspec-rails", "~> 6.1"
  gem "factory_bot_rails", "~> 6.4"
  gem "faker", "~> 3.2"
  gem "shoulda-matchers", "~> 7.0"
  gem "dotenv-rails"                      # .env support in dev/test
end

group :development do
  gem "web-console"
  gem "listen"
  gem "rack-mini-profiler"                # Performance profiling
  gem "bullet"                            # N+1 query detection
  gem "annotate"                          # Adds schema comments to models
  gem "letter_opener"                     # Preview emails in browser
  gem "rubocop-rails-omakase", require: false  # Rails opinionated linting
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "webmock", "~> 3.23"              # Stub HTTP (CAQH, Stripe webhooks)
  gem "vcr", "~> 6.2"                   # Record/replay external HTTP
end

group :production do
  gem "thruster"                          # HTTP asset caching + compression proxy for Puma
  gem "lograge"                           # Single-line structured logs
  gem "sentry-ruby"                       # Error tracking
  gem "sentry-rails"
end

gem "sprockets-rails", "~> 3.5"
