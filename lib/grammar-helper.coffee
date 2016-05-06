CSON = require 'season'
path = require 'path'

class GrammarHelper

  constructor: (@rootInputDirectory, @rootOutputDirectory) ->

  readGrammarFile: (file) ->
    new Promise (resolve, reject) =>
      filepath = path.join __dirname, @rootInputDirectory, file
      CSON.readFile filepath, (error, content) ->
        if error? then reject error else resolve content

  writeGrammarFile: (grammar, file) ->
    new Promise (resolve, reject) =>
      outputFilepath = path.join __dirname, @rootOutputDirectory, file
      CSON.writeFile outputFilepath, grammar, (error, written) ->
        if error? then reject error else resolve written

  appendPartialGrammars: (grammar, partialGrammarFiles) ->
    Promise.all partialGrammarFiles.map (grammarFile) =>
      @readGrammarFile grammarFile
        .then (partialGrammar) ->
          {key, patterns} = partialGrammar
          if key? and patterns?
            grammar.repository[key] =
              patterns: patterns
          partialGrammar

module.exports = GrammarHelper
