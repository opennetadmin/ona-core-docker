ONA-CORE Docker
===============

Docker image for `ona-core` 

only listens on https/443.

``` docker run -p 443:443 --name="ona" opennetadmin:ona-core

Then point your browser to https://localhost to get the api documentation page.

You can point to https://localhost/rest.php/v1 as the base rest API endpoint


TODO:

execute the installer script using ENV vars as input.
