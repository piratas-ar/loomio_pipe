# Loomio Pipe

Loomio's reply by email feature using \*nix pipes.

## Description

Allows participants to post comments on Loomio via email, by replying to
the notification special address.  The `loomio_pipe` script will read
the email from standard input and post it to your Loomio's API address.

## Why!

Loomio uses an special Reply-To address with these fields concatenated
as a query string:

* **u:** `User.id`
* **k:** `User.email_api_key`
* **d:** `Discussion.id`

The address looks like:

```
u=1&k=1111111111111111&d=1@your.loomio.in
```

Which are processed by a dedicated nodejs SMTP server and posted as JSON
requests to loomio's API.

`loomio_pipe` receives the email from any SMTP server via standard input
and posts it to loomio's API.

To use `loomio_pipe`, you'll need to merge our [pipe_to_api][] branch.
This makes Loomio craft Reply-To addresses that your regular SMTP server
can recognize and pipe to `loomio_pipe`:

```
loomio+u=1&k=1111111111111111&d=1@your.loomio.in
```

[pipe_to_api]: https://github.com/piratas-ar/loomio/tree/pipe_to_api

## Installation

### Postfix

Make sure Postfix uses the plus sign as recipient_delimiter:

```bash
# postconf -e recipient_delimiter='+'
# postfix reload
```

Add an alias for loomio addresses that runs `loomio_pipe`:

```bash
# echo 'loomio: "|/path/to/loomio_pipe https://your.loomio.in"' >>/etc/postfix/aliases
# newaliases
```

**Note:** On some systems, the `aliases` file is on `/etc/aliases`.
Check your postfix config if unsure: `postconf alias_maps`

## TODO

* Verify GPG signatures and drop emails not signed correctly
* Decrypt with GPG if we have a key
* What happens with plain text emails?
