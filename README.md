# Rails + Angular + PostgreSQL + Docker

## Setup Instructions

1. **Clone the repo**
```bash
git clone https://github.com/jdscdev/rails-angular-pg-docker
cd rails-angular-pg-docker
```

2. **Start the project**
```bash
docker-compose up --build

# To remove Docker containers and volumes
docker-compose down -v --remove-orphans 
```

3. **Visit the app**
- Frontend: http://localhost:4200
- Backend API: http://localhost:3000/api/products

4. **Test the project**
```bash
cd frontend
npm test src/tests

cd ../backend
jest tests
```

5. **Debug without Docker**
```bash
cd backend
rails server -b 0.0.0.0

cd ../frontend
npm start
```

6. **Running manually a Sidekiq job**
```bash
cd backend
# Opens rails console
rails c
# Inside rails console perform HelloJob (backend/app/sidekiq/hello_job.rb):
HelloJob.perform_async("Rails Developer")
exit
# Open Sidekiq terminal, check that "Hello, Rails Developer from Sidekiq!" is printed
bundle exec sidekiq
```