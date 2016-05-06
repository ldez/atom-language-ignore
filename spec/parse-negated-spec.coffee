describe 'Ignore grammar', ->
  grammar = null

  beforeEach ->
    waitsForPromise ->
      atom.packages.activatePackage 'language-ignore'

    runs ->
      grammar = atom.grammars.grammarForScopeName 'text.ignore'

  # convenience function during development
  debug = (tokens) ->
    console.log JSON.stringify(tokens, null, ' ')

  describe 'Should parse a "ignored file" line when', ->

    it 'contains a description without extension', ->
      {tokens} = grammar.tokenizeLine '!file'
      expect(tokens).toHaveLength 2
      expect(tokens[0]).toEqualJson value: '!', scopes: ['text.ignore', 'line.negated.ignore', 'markup.deleted.negate.content.ignore', 'constant.other.symbol.negate.ignore']
      expect(tokens[1]).toEqualJson value: 'file', scopes: ['text.ignore', 'line.negated.ignore', 'markup.deleted.negate.content.ignore']

    it 'contains a description with extension', ->
      {tokens} = grammar.tokenizeLine '!file.txt'
      expect(tokens).toHaveLength 2
      expect(tokens[0]).toEqualJson value: '!', scopes: ['text.ignore', 'line.negated.ignore', 'markup.deleted.negate.content.ignore', 'constant.other.symbol.negate.ignore']
      expect(tokens[1]).toEqualJson value: 'file.txt', scopes: ['text.ignore', 'line.negated.ignore', 'markup.deleted.negate.content.ignore']

  describe 'Should parse a "ignored directory" line when', ->

    it 'contains a simple description', ->
      {tokens} = grammar.tokenizeLine '!directory/'
      expect(tokens).toHaveLength 3
      expect(tokens[0]).toEqualJson value: '!', scopes: ['text.ignore', 'line.negated.ignore', 'markup.deleted.negate.content.ignore', 'constant.other.symbol.negate.ignore']
      expect(tokens[1]).toEqualJson value: 'directory', scopes: ['text.ignore', 'line.negated.ignore', 'markup.deleted.negate.content.ignore']
      expect(tokens[2]).toEqualJson value: '/', scopes: ['text.ignore', 'line.negated.ignore', 'markup.deleted.negate.content.ignore', 'constant.separator.directory.ignore']

    it 'contains a description with sub-directory', ->
      {tokens} = grammar.tokenizeLine '!directory1/directory2/'
      expect(tokens).toHaveLength 5
      expect(tokens[0]).toEqualJson value: '!', scopes: ['text.ignore', 'line.negated.ignore', 'markup.deleted.negate.content.ignore', 'constant.other.symbol.negate.ignore']
      expect(tokens[1]).toEqualJson value: 'directory1', scopes: ['text.ignore', 'line.negated.ignore', 'markup.deleted.negate.content.ignore']
      expect(tokens[2]).toEqualJson value: '/', scopes: ['text.ignore', 'line.negated.ignore', 'markup.deleted.negate.content.ignore', 'constant.separator.directory.ignore']
      expect(tokens[3]).toEqualJson value: 'directory2', scopes: ['text.ignore', 'line.negated.ignore', 'markup.deleted.negate.content.ignore']
      expect(tokens[4]).toEqualJson value: '/', scopes: ['text.ignore', 'line.negated.ignore', 'markup.deleted.negate.content.ignore', 'constant.separator.directory.ignore']
