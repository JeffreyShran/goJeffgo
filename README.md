# goJeffgo

Debian golang version is always behind, this short shell script will pull the latest direct from Google.

Tested with success on the following systems:

* Debian GNU/Linux-amd64 10 (buster) on WSL2 (bash) with a normal (non-root) user.

## Getting Started

These instructions will get you up and running. This script searches for existing installs and will compare version with that available from Google therefore running in in succession will also allow you to update by completely removing and re-installing golang.

### Prerequisites

##### On Debian

```
sudo apt install wget
```

### Running

```
wget -q -O - "https://raw.githubusercontent.com/JeffreyShran/goJeffgo/master/goJeffgo.sh" | bash
```

## Contributing / Feedback / Requests

I'm always happy to receive any feedback good or bad, the best way to do that is on Twitter, my handle is @jeffreyshran. Theres not much to contribute to but if you wish to then please do so by pull request & any change requests should be sent by raising an issue please.


## Authors

* **Jeffrey Shran** - *Twitter* - [@JeffreyShran](https://twitter.com/JeffreyShran)


## License

This project is licensed under the MIT License
