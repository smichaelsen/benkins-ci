# Benkins

These scripts roughly mimics what a CI server does when starting jobs on workers.
It can help to try out worker images locally.

Setup:

````
cp ci-build-script.dist ci-build-script
cp .env.dist .env
````

Adjust the values in the `.env` file to your needs.

Usage:

````
./trigger_build
````