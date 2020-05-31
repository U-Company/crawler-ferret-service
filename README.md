# Crawler ferret service

Crawler project intend of to prevent interface for parsing html pages with ferret. We do it, because we don't find 
implementation another fql/dsl language. 

This repo implements python package with methods of 
[python-clients package](https://github.com/U-Company/python-clients). Python-clients package is correct way to 
implement client to service. We publish our client to PyPi-registry. To install them, you can do this:

    pip install crawler-ferret-service
    
We save package with clients to our PyPi registry for crawler project.
    
After that, you can do this with async client:

    from clients import http
    from crawler_ferret_service import methods as crawler_ferret_service
    
    
    client = http.AsyncClient('http://localhost:8080')
    
    m = crawler_ferret_service.Root()
    resp, status = await client.request(m)
    print(resp)
    print(status)
    
Before request, you need to run the service:

    docker run -p 8080:8080 -it montferret/worker    
          
If you want to use sync client, you can do this:

    client = http.Client('http://localhost:8080')
    
    # ...
    
    resp, status = client.request(m)
    
    # ...

# Worker

<p align="center">
	<a href="https://goreportcard.com/report/github.com/MontFerret/worker">
		<img alt="Go Report Status" src="https://goreportcard.com/badge/github.com/MontFerret/worker">
	</a>
<!-- 	<a href="https://codecov.io/gh/MontFerret/worker">
		<img alt="Code coverage" src="https://codecov.io/gh/MontFerret/worker/branch/master/graph/badge.svg" />
	</a> -->
	<a href="https://discord.gg/kzet32U">
		<img alt="Discord Chat" src="https://img.shields.io/discord/501533080880676864.svg">
	</a>
	<a href="https://github.com/MontFerret/worker/releases">
		<img alt="Lab release" src="https://img.shields.io/github/release/MontFerret/worker.svg">
	</a>
   <a href="https://microbadger.com/images/montferret/worker">
      <img alt="Dockerimages" src="https://images.microbadger.com/badges/version/montferret/worker.svg">
   </a>
	<a href="http://opensource.org/licenses/MIT">
		<img alt="MIT License" src="http://img.shields.io/badge/license-MIT-brightgreen.svg">
	</a>
</p>

**Worker** is a simple HTTP server that accepts FQL queries, executes them and returns their results.

## Quick start

The Worker is shipped with dedicated Docker image that contains headless Google Chrome, so feel free to run queries using `cdp` driver:

```.env
docker run -p 8080:8080 -it montferret/worker
```

Alternatively, if you want to use your own version of Chrome, you can run the Worker locally:

```sh
make
```

And then just make a POST request:

![worker](https://raw.githubusercontent.com/MontFerret/worker/master/assets/postman.png)

## System Resource Requirements
- 2 CPU
- 2 Gb of RAM

## Usage

### Endpoints

- ``[POST] /`` - Executes a given query. The payload must be an object with required "text" and optional "params" fields.
- ``[GET] /version`` - Returns a version of Chrome and Ferret.
- ``[GET] /health`` - Health check endpoint (for Kubernetes, e.g.).

### Run commands

```bash
  -chrome-ip string
        Google Chrome remote IP address (default "127.0.0.1")
  -chrome-port uint
        Google Chrome remote debugging port (default 9222)
  -help
        show this list
  -port uint
        port to listen (default 8080)
  -version
        show REPL version

```
