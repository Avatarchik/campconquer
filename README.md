# Camp Conquer

Konker? I just met 'er!

# TODO

- [ ] API Auth
- [ ] User Auth
- [ ] Admin Auth (Devise? we used `rails generate active_admin:install --skip-users`  )

## API Docs

### Atom

1. Install <https://atom.io/>
2. Install <http://apiworkbench.com/> with `apm install api-workbench`
    * **or** open `Settings/Preferences -> Install` and search for `api-workbench`
3. Activate [autosave](https://github.com/atom/autosave):

        autosave:
          enabled: true

4. Read <http://apiworkbench.com/docs/>

<!--
### command-line raml2html

raml2html doesn't fully support RAML 1.0 yet...

First, install [raml2html](https://github.com/raml2html/raml2html)
```
cd ..
git clone git@github.com:raml2html/raml2html.git
cd raml2html
git checkout raml1.0  # may no longer be needed?
chmod a+x ./bin/raml2html
npm install
```

Then go back to this dir and run:

```
../raml2html/bin/raml2html campconquer.raml > campconquer-api.html && open campconquer-api.html
```
-->

### sample request

```
outcome[winner]:red
outcome[team_outcomes][][team]:red
outcome[team_outcomes][][takedowns]:20
outcome[team_outcomes][][throws]:6
outcome[team_outcomes][][team]:blue
outcome[team_outcomes][][takedowns]:10
outcome[team_outcomes][][throws]:12
```

## Admin

We are using ActiveAdmin for some non-API UI

<http://activeadmin.info/docs/documentation.html>


## Local Development Setup

* `git pull`
* `bundle install`
* edit `.env` (see below)
* `rake db:migrate`
* `rails server`

Alex recommends [JSON Viewer](https://chrome.google.com/webstore/detail/json-viewer/gbmdgpbipfallnflgajpaliibnhdgobh) for nicely viewing JSON output in Chrome

and [Postman](https://chrome.google.com/webstore/detail/postman/fhbjgbiflinjbdggehcddcbncdddomop?utm_source=chrome-ntp-launcher) for exploring APIs

## Local development with FitBit

* Create an app for yourself at <https://dev.fitbit.com/apps>

* Put values inside `.env` in the project dir, e.g.:

      FITBIT_CLIENT_ID=227W5K
      FITBIT_CLIENT_SECRET=d4d5c9c23c517c19ba238851c153f771
      FITBIT_CALLBACK_URL=http://localhost:3000/players/auth-callback

> Note that FITBIT_CALLBACK_URL **must** correspond with the *Callback URL* on https://dev.fitbit.com/apps/edit/xxxxx

* https://ngrok.com/ may be useful if you want to demo a locally-running app to someone on the wider Internet

# Staging

## Deploy to Heroku

```
git push heroku
heroku run rake db:migrate
heroku config:set `cat .env`
```

## FitBit Integration Is (Barely) Functional!

* Create a player: https://campconquer-staging.herokuapp.com/admin/players/new
* **NOTE THE ID** and use it below instead of 999
* Authenticate that player: https://campconquer-staging.herokuapp.com/players/999/auth
* See your profile: https://campconquer-staging.herokuapp.com/players/999/profile
* See your steps for the past 3 months: https://campconquer-staging.herokuapp.com/players/999/steps
* See your activities from yesterday: https://campconquer-staging.herokuapp.com/players/999/activities

Want to see what other Fitbit info is available? Check out https://dev.fitbit.com/docs/activity/ for docs


# Unity links

BestHTTP: https://docs.google.com/document/d/181l8SggPrVF1qRoPMEwobN_1Fn7NXOu-VtfjE6wvokg/edit#

Game Database:
https://docs.google.com/spreadsheets/d/1LY9Iklc3N7RkdJKkiuVNsMJ07TFsBi973VmIqgnLO6c/
