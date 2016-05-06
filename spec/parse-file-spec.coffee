describe 'Should parse a "file" line when', ->
  grammar = null

  beforeEach ->
    waitsForPromise ->
      atom.packages.activatePackage 'language-ignore'

    runs ->
      grammar = atom.grammars.grammarForScopeName 'text.ignore'

  # convenience function during development
  debug = (tokens) ->
    console.log JSON.stringify(tokens, null, ' ')

  it 'contains a description without extension', ->
    {tokens} = grammar.tokenizeLine 'file'
    expect(tokens).toHaveLength 1
    expect(tokens[0]).toEqualJson value: 'file', scopes: ['text.ignore', 'line.file.ignore', 'keyword.file.content.ignore']

  it 'contains a description with extension', ->
    {tokens} = grammar.tokenizeLine 'file.txt'
    expect(tokens).toHaveLength 1
    expect(tokens[0]).toEqualJson value: 'file.txt', scopes: ['text.ignore', 'line.file.ignore', 'keyword.file.content.ignore']

  it 'contains a description with extension and asterisk', ->
    {tokens} = grammar.tokenizeLine '*.txt'
    expect(tokens).toHaveLength 2
    expect(tokens[0]).toEqualJson value: '*', scopes: ['text.ignore', 'line.file.ignore', 'keyword.file.content.ignore', 'constant.other.symbol.asterisk.ignore']
    expect(tokens[1]).toEqualJson value: '.txt', scopes: ['text.ignore', 'line.file.ignore', 'keyword.file.content.ignore']

  it 'contains a description with extension and rangge', ->
    {tokens} = grammar.tokenizeLine 'file[a-b].txt'
    expect(tokens).toHaveLength 5
    expect(tokens[0]).toEqualJson value: 'file', scopes: ['text.ignore', 'line.file.ignore', 'keyword.file.content.ignore']
    expect(tokens[1]).toEqualJson value: '[', scopes: ['text.ignore', 'line.file.ignore', 'keyword.file.content.ignore', 'range.ignore', 'constant.other.symbol.range.begin.ignore']
    expect(tokens[2]).toEqualJson value: 'a-b', scopes: ['text.ignore', 'line.file.ignore', 'keyword.file.content.ignore', 'range.ignore', 'constant.other.symbol.range.content.ignore']
    expect(tokens[3]).toEqualJson value: ']', scopes: ['text.ignore', 'line.file.ignore', 'keyword.file.content.ignore', 'range.ignore', 'constant.other.symbol.range.end.ignore']
    expect(tokens[4]).toEqualJson value: '.txt', scopes: [ 'text.ignore', 'line.file.ignore', 'keyword.file.content.ignore']

  it 'contains a description without extension and with sub-directory', ->
    {tokens} = grammar.tokenizeLine 'directory/file'
    expect(tokens).toHaveLength 3
    expect(tokens[0]).toEqualJson value: 'directory', scopes: [ 'text.ignore', 'line.file.ignore', 'keyword.file.content.ignore']
    expect(tokens[1]).toEqualJson value: '/', scopes: [ 'text.ignore', 'line.file.ignore', 'keyword.file.content.ignore', 'constant.separator.directory.ignore']
    expect(tokens[2]).toEqualJson value: 'file', scopes: ['text.ignore', 'line.file.ignore', 'keyword.file.content.ignore']

  it 'contains a description with extension and with sub-directory', ->
    {tokens} = grammar.tokenizeLine 'directory/file.txt'
    expect(tokens).toHaveLength 3
    expect(tokens[0]).toEqualJson value: 'directory', scopes: [ 'text.ignore', 'line.file.ignore', 'keyword.file.content.ignore']
    expect(tokens[1]).toEqualJson value: '/', scopes: [ 'text.ignore', 'line.file.ignore', 'keyword.file.content.ignore', 'constant.separator.directory.ignore']
    expect(tokens[2]).toEqualJson value: 'file.txt', scopes: ['text.ignore', 'line.file.ignore', 'keyword.file.content.ignore']

  it 'contains a description without extension with restiction', ->
    {tokens} = grammar.tokenizeLine '/file'
    expect(tokens).toHaveLength 2
    expect(tokens[0]).toEqualJson value: '/', scopes: ['text.ignore', 'line.file.ignore', 'constant.restriced.file.ignore']
    expect(tokens[1]).toEqualJson value: 'file', scopes: ['text.ignore', 'line.file.ignore', 'keyword.file.content.ignore']

  it 'contains a description with extension and restiction', ->
    {tokens} = grammar.tokenizeLine '/file.txt'
    expect(tokens).toHaveLength 2
    expect(tokens[0]).toEqualJson value: '/', scopes: ['text.ignore', 'line.file.ignore', 'constant.restriced.file.ignore']
    expect(tokens[1]).toEqualJson value: 'file.txt', scopes: ['text.ignore', 'line.file.ignore', 'keyword.file.content.ignore']

  it 'contains a description with extension and asterisk and restiction', ->
    {tokens} = grammar.tokenizeLine '/*.txt'
    expect(tokens).toHaveLength 3
    expect(tokens[0]).toEqualJson value: '/', scopes: ['text.ignore', 'line.file.ignore', 'constant.restriced.file.ignore']
    expect(tokens[1]).toEqualJson value: '*', scopes: ['text.ignore', 'line.file.ignore', 'keyword.file.content.ignore', 'constant.other.symbol.asterisk.ignore']
    expect(tokens[2]).toEqualJson value: '.txt', scopes: ['text.ignore', 'line.file.ignore', 'keyword.file.content.ignore']

  it 'contains a description with extension and rangge and restiction', ->
    {tokens} = grammar.tokenizeLine '/file[a-b].txt'
    expect(tokens).toHaveLength 6
    expect(tokens[0]).toEqualJson value: '/', scopes: ['text.ignore', 'line.file.ignore', 'constant.restriced.file.ignore']
    expect(tokens[1]).toEqualJson value: 'file', scopes: ['text.ignore', 'line.file.ignore', 'keyword.file.content.ignore']
    expect(tokens[2]).toEqualJson value: '[', scopes: ['text.ignore', 'line.file.ignore', 'keyword.file.content.ignore', 'range.ignore', 'constant.other.symbol.range.begin.ignore']
    expect(tokens[3]).toEqualJson value: 'a-b', scopes: ['text.ignore', 'line.file.ignore', 'keyword.file.content.ignore', 'range.ignore', 'constant.other.symbol.range.content.ignore']
    expect(tokens[4]).toEqualJson value: ']', scopes: ['text.ignore', 'line.file.ignore', 'keyword.file.content.ignore', 'range.ignore', 'constant.other.symbol.range.end.ignore']
    expect(tokens[5]).toEqualJson value: '.txt', scopes: [ 'text.ignore', 'line.file.ignore', 'keyword.file.content.ignore']

  it 'contains a description without extension and with sub-directory and restiction', ->
    {tokens} = grammar.tokenizeLine '/directory/file'
    expect(tokens).toHaveLength 4
    expect(tokens[0]).toEqualJson value: '/', scopes: ['text.ignore', 'line.file.ignore', 'constant.restriced.file.ignore']
    expect(tokens[1]).toEqualJson value: 'directory', scopes: [ 'text.ignore', 'line.file.ignore', 'keyword.file.content.ignore']
    expect(tokens[2]).toEqualJson value: '/', scopes: [ 'text.ignore', 'line.file.ignore', 'keyword.file.content.ignore', 'constant.separator.directory.ignore']
    expect(tokens[3]).toEqualJson value: 'file', scopes: ['text.ignore', 'line.file.ignore', 'keyword.file.content.ignore']

  it 'contains a description with extension and with sub-directory and restiction', ->
    {tokens} = grammar.tokenizeLine '/directory/file.txt'
    expect(tokens).toHaveLength 4
    expect(tokens[0]).toEqualJson value: '/', scopes: ['text.ignore', 'line.file.ignore', 'constant.restriced.file.ignore']
    expect(tokens[1]).toEqualJson value: 'directory', scopes: [ 'text.ignore', 'line.file.ignore', 'keyword.file.content.ignore']
    expect(tokens[2]).toEqualJson value: '/', scopes: [ 'text.ignore', 'line.file.ignore', 'keyword.file.content.ignore', 'constant.separator.directory.ignore']
    expect(tokens[3]).toEqualJson value: 'file.txt', scopes: ['text.ignore', 'line.file.ignore', 'keyword.file.content.ignore']
