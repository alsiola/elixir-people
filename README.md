# People

## Dependencies
The application uses the Phoenix framework and its associated dependencies. Additionally, the `CSV` library is used for parsing CSV files.  Dependencies are installed with:

```
    mix deps.get
```

## Database
### PostGres DB Server
This project uses a PostGres database. For development, a `docker-compose.yml` file is included that will start an instance of PostGres on port 5432, and an instance of Adminer (web-based DB admin tool) on port 5433. The password for these local instances is set to `postgres`.

If Docker is not available, then modify `config/dev.exs` with the appropriate settings for a locally running PostGres server.

To start the dockerized database, in the root of the project run:

```
    docker-compose up -d
```

The current docker setup does not mount any volumes - as a consequence any databases, schemas and stored data is not persisted when the container is shut down.

### Database initialisation
The `people_dev` database can be created by running:

```
    mix ecto.create
```

### Seeding data
Data can be seeded from any CSV file that has the headers `name`, `role`, `location` and `photo`. Run:

```
    mix run priv/repo/seeds.exs
```

Enter the location of the CSV file (relative to the current working directory) and all users in the file will be added to the database.

## Running The Application
Once the database is started and initialised the application can be run with:

```
    mix phx.server
```

## Tests
Tests can be run using:

```
    mix test
```