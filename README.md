# Withoutrails
#### Description:
The main target, to create Rack application without Rails framework.
#### TODO at Current Time:
* Custom logger (Not required, JFF).
* Test framework support.
* Database connection.
* Sources hot reloading (grape issue).
* Different environments.
* write README ;)

### Application HOWTO:
* Run `bundle` in project root for gems installation.
* For run application server, run at console:
`rackup`, or `RACK_ENV=test rackup` with specific environment, as `test` in example. Default is `development`.

### Docker Support:
* Install `Docker` and insure, that service booted up.
* To build `Docker` image, run at project directory:

  ```docker build -t withoutrails .```

  where `withoutrails` is image name, feel free to use other name.

  Then run container with `bash` session:

  ```bash
  docker run --name withoutrails-app --rm -v $(pwd):/usr/src/ -itP withoutrails
  ```
  where:
  * `--name` container name, feel free to change it.
  * `--rm` container will be automatically removed after usage.
  * `-v` link project directory as volume, it means you make changes locally in your favorite editor and it's applying in container.
  * `-itP` run container with interactive session (bash in that case) and link ports from `withoutrails` image.
* Execute certain bash command at container, `bundle install` for instance:

  ```
  docker exec -it withoutrails-app bash -c "bundle install"
  ```
