GrammarHelper = require '../lib/grammar-helper'

describe 'Grammar helper', ->

  helper = new GrammarHelper('../spec/fixtures/grammars/', '../spec/output/')

  it 'should create a grammar object when read a grammar file', ->
    fileContent = null

    waitsForPromise ->
      helper.readGrammarFile('sample01.cson').then (r) -> fileContent = r

    runs ->
      expect(fileContent).toEqualJson key: 'test', patterns: ['foo', 'bar']

  it 'should append file content to existing grammar when read a partial grammar file', ->
    grammar =
      repository: {}

    partialGrammarFiles = [
      'sample01.cson'
    ]

    waitsForPromise ->
      helper.appendPartialGrammars grammar, partialGrammarFiles

    runs ->
      expect(grammar).toEqualJson repository: test: patterns: ['foo', 'bar']
