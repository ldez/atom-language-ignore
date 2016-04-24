{CompositeDisposable} = require 'atom'
CSON = require 'season'
helper = require './grammar-helper'

module.exports =

  subscriptions: null

  activate: (state) ->
    @subscriptions = new CompositeDisposable()

    if atom.inDevMode()
      @subscriptions.add atom.commands.add 'atom-workspace', 'ignore:compile-grammar-and-reload': => @compileGrammar()

  compileGrammar: (debug) ->
    if atom.inDevMode()

      # gitignore & coffeelintignore & npmignore & dockerignore
      rootGrammar = helper.readGrammarFile 'ignore.cson'
      rootGrammar.name = 'Ignore File (gitignore syntax)'
      rootGrammar.scopeName = 'text.ignore'
      rootGrammar.fileTypes = [
        'gitignore'
        'npmignore'
        'coffeelintignore'
        'dockerignore'
      ]

      partialGrammars = [
        '/symbols/negate-symbols.cson'
        '/symbols/basic-symbols.cson'
        '/lines/negate.cson'
        '/lines/directory.cson'
        '/lines/file.cson'
      ]
      helper.appendPartialGrammars rootGrammar, partialGrammars

      if debug?
        console.log CSON.stringify rootGrammar
      helper.writeGrammarFile rootGrammar, 'language-ignore.cson'

      # slugignore
      rootGrammar = helper.readGrammarFile 'ignore.cson'
      rootGrammar.name = 'Ignore File for Slug compiler (gitignore syntax)'
      rootGrammar.scopeName = 'text.ignore.slugignore'
      rootGrammar.fileTypes = [
        'slugignore'
      ]

      partialGrammars = [
        '/symbols/negate-illegal-symbols.cson'
        '/symbols/basic-symbols.cson'
        '/lines/negate.cson'
        '/lines/directory.cson'
        '/lines/file.cson'
      ]
      helper.appendPartialGrammars rootGrammar, partialGrammars

      if debug?
        console.log CSON.stringify rootGrammar
      helper.writeGrammarFile rootGrammar, 'language-ignore-slug.cson', do ->
        atom.commands.dispatch 'body', 'window:reload'

    deactivate: ->
      @subscriptions.dispose()
