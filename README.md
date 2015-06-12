# hsg

This project is the beginning of a project to build a new history.state.gov:

- As an EXPath Package for easy deployment within eXist
- Eventually, to consist of multiple packages for data and code, to lighten the weight and reduce burden for contributors
- Using [bower](http://bower.io/) to handle CSS and Javascript dependencies
- Using RestXQ to handle URL rewriting within eXist, and separate URL and content concerns

## Steps to get set up for development once you've cloned this repository

- Install [homebrew](http://brew.sh#install), or if already installed: `brew update && brew upgrade`
- Install dependencies part 1 (git, npm, and ruby): `brew install git npm ruby`
- Install dependencies part 2 ([bower](http://bower.io/) and [grunt](http://gruntjs.com/)): `npm install -g bower grunt-cli`
- Install dependencies part 3 ([bootstrap](https://github.com/twbs/bootstrap), [bigfoot.js](http://www.bigfootjs.com/), and their dependencies, as defined in the project's `bower.json` file): `bower install`
- Run `ant` to generate the `.xar` file inside the `build` directory
- Install the `build/hsg-x.y.z.xar` via the eXist Dashboard Package Manager
- Click on the "history.state.gov" icon from the eXist Dashboard
- Follow the menu options to load data, start hsg
- Optional: follow directions below for installing local offline copy of bootstrap documentation

## Steps to reproduce my initial setup

- Install [homebrew](http://brew.sh#install)
- Install git, npm, and ruby: `brew install git npm ruby`
- Install [bower](http://bower.io/) and [grunt](http://gruntjs.com/): `npm install -g bower grunt-cli`
- Install [bootstrap](https://github.com/twbs/bootstrap): `bower install bootstrap`
- I ran `bower init` to create a bower.json file
- Used bower to install bigfoot, using the `save` flag to add bigfoot to the dependencies listed in bower.json: `bower install bigfoot --save`
- Following bootstrap's [directions for installing Grunt](http://getbootstrap.com/getting-started/#grunt) I ran `npm install` in the bootstrap directory

## To have a local copy of bootstrap documentation
  - Clone [bootstrap](https://github.com/twbs/bootstrap) via `https://github.com/twbs/bootstrap.git`
  - Install [Jekyll](http://jekyllrb.com/docs/installation/) to be able to view bootstrap docs locally: `gem install jekyll`
  - But I had to run this to get around [jekyll installation errors](https://github.com/wayneeseguin/rvm/issues/2689#issuecomment-52753818) `brew unlink libyaml && brew link libyaml`
  - In the bootstrap clone directory, run `jekyll serve`, then view bootstrap documentation at http://localhost:9001/
