## 0.0.1

First release version

## 0.0.2

Updating documentation

## 0.0.3

- Apikey is deprecated, change it to use PAT instead. See [here](https://api.gandi.net/docs/authentication/).
- Use simpler architecture, with a simple script copied in the docker image and a config.yaml file, following the [custom addon tutorial](https://developers.home-assistant.io/docs/add-ons/tutorial/#the-runsh-file)
- Add better documentation and a button to install the repo on homeassistant with a simple click (taken from the [custom addon example](https://github.com/home-assistant/addons-example))
- Change the script to be simply run once, since by default it runs at boot. For regular updating, a scheduler can be used, similar to Let's Encrypt
