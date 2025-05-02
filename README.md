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
