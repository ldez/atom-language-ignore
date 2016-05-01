GrammarHelper = require '../lib/grammar-helper'

describe "Grammar helper", ->

  helper = null

  beforeEach ->
    helper = new GrammarHelper('../spec/fixtures/grammars/', '../spec/output/')

  it 'should create a grammar object when read a grammar file', ->
    fileContent = helper.readGrammarFile 'sample01.cson'
    expect(fileContent.key).toEqual 'test'
    expect(fileContent.patterns).toHaveLength 2
    expect(fileContent.patterns[0]).toEqual 'foo'
    expect(fileContent.patterns[1]).toEqual 'bar'

  it 'should append file content to existing grammar when read a partial grammar file', ->
    grammar =
      repository: {}

    partialGrammarFiles = [
      'sample01.cson'
    ]

    helper.appendPartialGrammars grammar, partialGrammarFiles

    expect(grammar.repository.test).toBeDefined()
    expect(grammar.repository.test.patterns).toBeDefined()
    expect(grammar.repository.test.patterns).toHaveLength 2
    expect(grammar.repository.test.patterns).toEqual ['foo', 'bar']
