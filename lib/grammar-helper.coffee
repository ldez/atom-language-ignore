CSON = require 'season'
path = require 'path'

module.exports =

  readGrammarFile: (file) ->
    rootDirectory = '../grammars/repositories/'
    filepath = path.join __dirname, rootDirectory, file
    CSON.readFileSync filepath

  writeGrammarFile: (grammar, file, cal) ->
    rootDirectory = '../grammars/'
    outputFilepath = path.join __dirname, rootDirectory, file
    CSON.writeFileSync outputFilepath, grammar

  appendPartialGrammars: (grammar, partialGrammarFiles) ->
    for grammarFile in partialGrammarFiles
      {key, patterns} = @readGrammarFile grammarFile
      if key? and patterns?
        grammar.repository[key] =
          patterns: patterns
