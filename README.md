# django-droidstore

This is an Android app store written in Django.  No frills. :-)

# Requirements

Droidstore requires Docker Engine 1.10.0+ and Docker Compose 1.6.0+.

# Standard workflow

This needs to be written!

# Development tips

## Building the software

There's a `./dev-setup.sh` script which should do the right thing.

The SSL setup is a little hairy.  To recreate it:
* Make a directory, and put this script in it: https://gist.github.com/mrw34/c97bb03ea1054afb551886ffc8b63c3b
* `./postgres.sh && sudo chown -R 999:130 . && sudo chmod 600 server.key && tar cf ~/git/pyment/devssl.tar .`

## Testing the software

After running the aforementioned script, try this: `docker-compose run --rm web python -X dev manage.py test`.

## Running a local instance for testing purposes

Copy the example env file mentioned above to the target location, re-run the script mentioned above, and try this:  `docker-compose up`.

The example env file includes a reference to `localhost` in `ALLOWED_HOSTS` which makes the website work when visited at `http://localhost:8000` for testing.

# License

This software is released under the [MIT license](http://opensource.org/licenses/mit-license.php).
