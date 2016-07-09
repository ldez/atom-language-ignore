# Ignore files Package for Atom

[![Atom Package](https://img.shields.io/apm/v/language-ignore.svg)](https://atom.io/packages/language-ignore)
[![Atom Package Downloads](https://img.shields.io/apm/dm/language-ignore.svg)](https://atom.io/packages/language-ignore)
[![Build Status (Linux & OSX)](https://travis-ci.org/ldez/atom-language-ignore.svg?branch=master)](https://travis-ci.org/ldez/atom-language-ignore)
[![Build status (Windows)](https://ci.appveyor.com/api/projects/status/hqhpnne2dungfbj1?svg=true)](https://ci.appveyor.com/project/ldez/atom-language-ignore)
[![MIT License](http://img.shields.io/badge/license-MIT-blue.svg?style=flat)](https://github.com/ldez/atom-language-ignore/blob/master/LICENSE.md)

Adds syntax highlighting to 'ignore' files.

![language-ignore-gitignore](https://cloud.githubusercontent.com/assets/5674651/14763858/4ae7eae4-09a3-11e6-9adf-94f3d5cdf1d6.png)


## Supported files

- `.gitignore`: references [gitignore](https://git-scm.com/docs/gitignore) and [Ignoring-Files](https://git-scm.com/book/en/v2/Git-Basics-Recording-Changes-to-the-Repository#Ignoring-Files)
- `.npmignore`: works just like a `.gitignore` [references](https://docs.npmjs.com/misc/developers#keeping-files-out-of-your-package)
- `.dockerignore` : works just like a `.gitignore` [references](https://docs.docker.com/engine/reference/builder/#dockerignore-file)
- `.coffeelintignore`: works just like a `.gitignore`.
- `.slugignore`: does not support negated `!` patterns. [Heroku - Slug Compiler](https://devcenter.heroku.com/articles/slug-compiler#ignoring-files-with-slugignore)
- `.atomignore`: works just like a `.gitignore`. [tree-ignore](https://atom.io/packages/tree-ignore)
- `.hgignore`: references [hgignore](https://www.mercurial-scm.org/wiki/.hgignore) (currently only glop patterns)
- `.vscodeignore`: works just like a `.gitignore` [references](https://code.visualstudio.com/docs/tools/vscecli#_advance-usage)

## Install

Settings/Preferences > Install > Search for `language-ignore`

Or

```bash
apm install language-ignore
```
