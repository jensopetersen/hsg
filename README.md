# hsg

This project is the beginning of a project to build a new history.state.gov:

- As an EXPath Package for easy deployment within eXist
- Eventually, to consist of multiple packages for data and code, to lighten the weight and reduce burden for contributors
- Using [bower](http://bower.io/) to handle CSS and Javascript dependencies
- Using RestXQ to handle URL rewriting within eXist, and separate URL and content concerns

## Steps to get set up for development once you've cloned this repository

- Install [homebrew](http://brew.sh#install)
- Install git, npm, and ruby: `brew install git npm ruby`
- Install [bower](http://bower.io/) and [grunt](http://gruntjs.com/): `npm install -g bower grunt-cli`
- Install [bootstrap](https://github.com/twbs/bootstrap): `bower install bootstrap`
- Install [Jekyll](http://jekyllrb.com/docs/installation/): `gem install jekyll`

## Steps to reproduce my initial setup

- Install [homebrew](http://brew.sh#install)
- Install git, npm, and ruby: `brew install git npm ruby`
- Install [bower](http://bower.io/) and [grunt](http://gruntjs.com/): `npm install -g bower grunt-cli`
- Install [bootstrap](https://github.com/twbs/bootstrap): `bower install bootstrap`
- I ran `bower init` to create a bower.json file
- Following bootstrap's [directions for installing Grunt](http://getbootstrap.com/getting-started/#grunt) I ran `npm install` in the bootstrap directory
- Install [Jekyll](http://jekyllrb.com/docs/installation/) to be able to view bootstrap docs locally: `gem install jekyll`
- But I had to run this to get around [jekyll installation errors](https://github.com/wayneeseguin/rvm/issues/2689#issuecomment-52753818) `brew unlink libyaml && brew link libyaml`
- Used bower to install bigfoot, using the `save` flag to add bigfoot to the dependencies listed in bower.json: `bower install bigfoot --save`