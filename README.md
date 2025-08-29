[https://rails-project-65-1xds.onrender.com](https://rails-project-65-1xds.onrender.com)

# CI status
[![CI](https://github.com/amd-9/rails-project-65/actions/workflows/ci.yml/badge.svg)](https://github.com/amd-9/rails-project-65/actions/workflows/ci.yml)

### Hexlet tests and linter status:
[![Actions Status](https://github.com/amd-9/rails-project-65/actions/workflows/hexlet-check.yml/badge.svg)](https://github.com/amd-9/rails-project-65/actions)

# README

Awesome bulletins board

# System requirements
 * Ruby >= 3.2.2
 * PostgreSQL 17
 * SQLite 3 - for local development
 * libvps and imagemagick - for image processing

 # Setup
 ```sh
 make setup
 make install
 make test
 ```

 # Prepare DB
```sh
make db:migrate
```

 # Run
 ```sh
 make start
 ```
 