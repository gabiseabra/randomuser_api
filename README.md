## RandomUser API

## Getting Started

### Installation

Download the repository

```sh
git clone https://github.com/gabiseabra/randomuser_api
```

Install dependencies

```sh
bundle & yarn
```

### Development Server

Run `Procfile.dev` with foreman

```sh
foreman start -f ./Procfile.dev
```

**OR**

Start both servers simultaneously

```sh
rails s -p 3030
```

```sh
cd client && API_PORT=3030 yarn run start
```

Dev server can be accessed at http://localhost:3000 by default.

### Tests

Run tests with rspec

```sh
bundle exec rspec
```

### Docker

Set `SECRET_KEY_BASE` in the .env file and use docker-compose to build the containers.

```sh
docker-compose up
```

