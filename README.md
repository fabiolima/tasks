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

### Create an user to login. Skip this if you already created a user when installing Authentication API.

The created user is `admin@admin.com 123123`
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
### Navigate to http://localhost:3000
![image](https://github.com/user-attachments/assets/3ee4a8d7-81e6-4b76-9519-15e53d0fa11e)

### Log in, then navigate to dashboard.
![image](https://github.com/user-attachments/assets/80781d6f-d45a-44b6-aed4-4a5b8813f443)

### Create a task. Use any product page URL of Zara or Hering.
   - ``https://www.zara.com/br/pt/jaqueta-bomber-leve-p04302510.html?v1=364166582&v2=2481812``
   - ``https://www.hering.com.br/bermuda-em-sarja-masculina-chino-ktvg3asi/p``

![image](https://github.com/user-attachments/assets/89605852-7bec-4787-b493-61b868f27e4a)

### See webscraping results at task details page
![image](https://github.com/user-attachments/assets/9b0a689b-8306-4e5c-a016-31f58d158bd0)





