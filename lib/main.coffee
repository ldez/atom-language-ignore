{CompositeDisposable} = require 'atom'
CSON = require 'season'
GrammarHelper = require './grammar-helper'

module.exports =

  subscriptions: null
  debug: false

  activate: (state) ->
    return unless atom.inDevMode() and not atom.inSpecMode()

    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.commands.add 'atom-workspace', 'ignore:compile-grammar-and-reload': => @compileGrammar()

  compileGrammar: ->
    return unless atom.inDevMode() and not atom.inSpecMode()

    helper = new GrammarHelper '../grammars/repositories/', '../grammars/'

    # gitignore & coffeelintignore & npmignore & dockerignore
    promiseIgnore = helper.readGrammarFile 'ignore.cson'
      .then (rootGrammar) ->
        console.log "A1"
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
          .then =>
            console.log "A"
            if @debug then console.log CSON.stringify rootGrammar
            helper.writeGrammarFile rootGrammar, 'language-ignore.cson'

    # slugignore
    promiseSlugIgnore = helper.readGrammarFile 'ignore.cson'
      .then (rootGrammar) ->
        console.log "B1"
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
          .then =>
            console.log "B"
            if @debug then console.log CSON.stringify rootGrammar
            helper.writeGrammarFile rootGrammar, 'language-ignore-slug.cson'

    Promise.all [promiseIgnore, promiseSlugIgnore]
      .then ->
        atom.commands.dispatch 'body', 'window:reload'

    deactivate: ->
      @subscriptions.dispose()
