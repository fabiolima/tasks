# Tasks
> Create tasks to perform web scraping at Zara and Hering websites.

## Why?
I made this project to practice realtime notifications in Ruby on Rails.

## Dependencies
- [Redis](https://redis.io/docs/latest/operate/oss_and_stack/install/install-redis/install-redis-on-mac-os/) (Redis is the default adapter for ActionCable)
- [Postgres](https://www.postgresql.org/) (Feel free to change, devise supports multiple databases.)
- [Ruby](https://www.ruby-lang.org/en/)
- [Bundler](https://bundler.io/) 

## Pre requisites
- [Start the Authentication API](https://github.com/fabiolima/auth)
- [Start the Scraper API](https://github.com/fabiolima/scraper)

## Install
- Make shure that **Postgres** and **Redis** services are running
- Make shure that **Authentication API** and **Scraper API** are running ports ``3001`` and ``3002`` respectively.

After cloning this repository, navigate to project folder and run:
```bash
bundle install
```

Add credentials
```
For VSCode:
EDITOR="code --wait" rails credentials:edit --environment=development

Default editor:
rails credentials:edit --environment=development
```

Copy and paste the following content
```
endpoints:
  webhook: "http://localhost:3000/webhook"
  authenticate: "http://localhost:3001/login"
  scraper: "http://localhost:3002/scrape"
```
Save and close.



Now, create the database and run migrations
```
rails db:create && rails db:migrate
```

then spin up the web server
```bash
./bin/dev 
```
Default port for this project is `3000`. You can change at `config/puma.rb`

## Usage

1) Create an user to login. Skip this if you already created a user when installing Authentication API.

The user created is `admin@admin.com 123123`
```
curl --request POST \
  --url http://localhost:3001/signup \
  --header 'Content-Type: application/json' \
  --data '{
	"user": {
		"email": "admin@admin.com",
		"password": "123123"
	}
}'
```
2) Navigate to http://localhost:3000
