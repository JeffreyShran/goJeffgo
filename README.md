# goJeffgo

The golang version from package managers is always behind or so old that the installed version isn't useful at all. This short shell script will pull the latest version directly from Google and install or update the current version.

Does not support anything other than standard installs for the current user.

Tested with success on the following systems:

* Debian 10 (Buster) on WSL2 with a non-root user.
* Ubuntu 20.04.3 LTS (Focal Fossa) from Digital Ocean with a non-root user.

## Getting Started

These instructions will get you up and running. This script searches for existing installs and will compare version with that available from Google therefore running in in succession will also allow you to update by completely removing and re-installing golang.

### Prerequisites

##### On Debian

`curl` should already be installed, if not or you're unsure then run:
```
sudo apt install curl
```

### Running

Use the same command to install and update in the same way a traditional Go program would work:

```
curl https://raw.githubusercontent.com/JeffreyShran/goJeffgo/master/goJeffgo.sh | bash
```

## Contributing / Feedback / Requests

I'm always happy to receive any feedback good or bad, the best way to do that is on Twitter, my handle is @jeffreyshran. Theres not much to contribute to but if you wish to then please do so by pull request & any change requests should be sent by raising an issue please.


## Authors

* **Jeffrey Shran** - *Twitter* - [@JeffreyShran](https://twitter.com/JeffreyShran)


## License

This project is licensed under the MIT License.
