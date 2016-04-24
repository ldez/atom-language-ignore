describe 'Should parse a "directory" line when', ->
  grammar = null

  beforeEach ->
    waitsForPromise ->
      atom.packages.activatePackage 'language-ignore'

    runs ->
      grammar = atom.grammars.grammarForScopeName 'text.ignore'

  # convenience function during development
  debug = (tokens) ->
    console.log(JSON.stringify(tokens, null, ' '))

  it 'contains a simple description', ->
    {tokens} = grammar.tokenizeLine('directory/')
    expect(tokens).toHaveLength 2
    expect(tokens[0]).toEqual value: 'directory', scopes: ['text.ignore', 'line.directory.ignore', 'string.directory.content.ignore']
    expect(tokens[1]).toEqual value: '/', scopes: ['text.ignore', 'line.directory.ignore', 'constant.character.directory.ignore']

  it 'contains a description with sub-directory', ->
    {tokens} = grammar.tokenizeLine('directory1/directory2/')
    expect(tokens).toHaveLength 4
    expect(tokens[0]).toEqual value: 'directory1', scopes: ['text.ignore', 'line.directory.ignore', 'string.directory.content.ignore']
    expect(tokens[1]).toEqual value: '/', scopes: ['text.ignore', 'line.directory.ignore', 'string.directory.content.ignore', 'constant.separator.directory.ignore']
    expect(tokens[2]).toEqual value: 'directory2', scopes: ['text.ignore', 'line.directory.ignore', 'string.directory.content.ignore']
    expect(tokens[3]).toEqual value: '/', scopes: ['text.ignore', 'line.directory.ignore', 'constant.character.directory.ignore']

  it 'contains a description with sub-directory and asterisk', ->
    {tokens} = grammar.tokenizeLine('directory/*/')
    expect(tokens).toHaveLength 4
    expect(tokens[0]).toEqual value: 'directory', scopes: ['text.ignore', 'line.directory.ignore', 'string.directory.content.ignore']
    expect(tokens[1]).toEqual value: '/', scopes: ['text.ignore', 'line.directory.ignore', 'string.directory.content.ignore', 'constant.separator.directory.ignore']
    expect(tokens[2]).toEqual value: '*', scopes: ['text.ignore', 'line.directory.ignore', 'string.directory.content.ignore', 'constant.other.symbol.asterisk.ignore']
    expect(tokens[3]).toEqual value: '/', scopes: ['text.ignore', 'line.directory.ignore', 'constant.character.directory.ignore']

  it 'contains a description with sub-directory and asterisks', ->
    {tokens} = grammar.tokenizeLine('directory1/**/directory2/')
    expect(tokens).toHaveLength 7
    expect(tokens[0]).toEqual value: 'directory1', scopes: ['text.ignore', 'line.directory.ignore', 'string.directory.content.ignore']
    expect(tokens[1]).toEqual value: '/', scopes: ['text.ignore', 'line.directory.ignore', 'string.directory.content.ignore', 'constant.separator.directory.ignore']
    expect(tokens[2]).toEqual value: '*', scopes: ['text.ignore', 'line.directory.ignore', 'string.directory.content.ignore', 'constant.other.symbol.asterisk.ignore']
    expect(tokens[3]).toEqual value: '*', scopes: ['text.ignore', 'line.directory.ignore', 'string.directory.content.ignore', 'constant.other.symbol.asterisk.ignore']
    expect(tokens[4]).toEqual value: '/', scopes: ['text.ignore', 'line.directory.ignore', 'string.directory.content.ignore', 'constant.separator.directory.ignore']
    expect(tokens[5]).toEqual value: 'directory2', scopes: ['text.ignore', 'line.directory.ignore', 'string.directory.content.ignore']
    expect(tokens[6]).toEqual value: '/', scopes: ['text.ignore', 'line.directory.ignore', 'constant.character.directory.ignore']

  it 'contains a description with sub-directory and range', ->
    {tokens} = grammar.tokenizeLine('directory1/[a-z]/directory2/')
    expect(tokens).toHaveLength 8
    expect(tokens[0]).toEqual value: 'directory1', scopes: ['text.ignore', 'line.directory.ignore', 'string.directory.content.ignore']
    expect(tokens[1]).toEqual value: '/', scopes: ['text.ignore', 'line.directory.ignore', 'string.directory.content.ignore', 'constant.separator.directory.ignore']
    expect(tokens[2]).toEqual value: '[', scopes: ['text.ignore', 'line.directory.ignore', 'string.directory.content.ignore', 'range.ignore', 'constant.other.symbol.range.begin.ignore']
    expect(tokens[3]).toEqual value: 'a-z', scopes: ['text.ignore', 'line.directory.ignore', 'string.directory.content.ignore', 'range.ignore', 'constant.other.symbol.range.content.ignore']
    expect(tokens[4]).toEqual value: ']', scopes: ['text.ignore', 'line.directory.ignore', 'string.directory.content.ignore', 'range.ignore', 'constant.other.symbol.range.end.ignore']
    expect(tokens[5]).toEqual value: '/', scopes: ['text.ignore', 'line.directory.ignore', 'string.directory.content.ignore', 'constant.separator.directory.ignore']
    expect(tokens[6]).toEqual value: 'directory2', scopes: ['text.ignore', 'line.directory.ignore', 'string.directory.content.ignore']
    expect(tokens[7]).toEqual value: '/', scopes: ['text.ignore', 'line.directory.ignore', 'constant.character.directory.ignore']

  it 'contains a description with restiction', ->
    {tokens} = grammar.tokenizeLine('/directory/')
    expect(tokens).toHaveLength 3
    expect(tokens[0]).toEqual value: '/', scopes: ['text.ignore', 'line.directory.ignore', 'constant.restriced.directory.ignore']
    expect(tokens[1]).toEqual value: 'directory', scopes: ['text.ignore', 'line.directory.ignore', 'string.directory.content.ignore']
    expect(tokens[2]).toEqual value: '/', scopes: ['text.ignore', 'line.directory.ignore', 'constant.character.directory.ignore']

  it 'contains a description with sub-directory and restiction', ->
    {tokens} = grammar.tokenizeLine('/directory1/directory2/')
    expect(tokens).toHaveLength 5
    expect(tokens[0]).toEqual value: '/', scopes: ['text.ignore', 'line.directory.ignore', 'constant.restriced.directory.ignore']
    expect(tokens[1]).toEqual value: 'directory1', scopes: ['text.ignore', 'line.directory.ignore', 'string.directory.content.ignore']
    expect(tokens[2]).toEqual value: '/', scopes: ['text.ignore', 'line.directory.ignore', 'string.directory.content.ignore', 'constant.separator.directory.ignore']
    expect(tokens[3]).toEqual value: 'directory2', scopes: ['text.ignore', 'line.directory.ignore', 'string.directory.content.ignore']
    expect(tokens[4]).toEqual value: '/', scopes: ['text.ignore', 'line.directory.ignore', 'constant.character.directory.ignore']

  it 'contains a description with sub-directory and restiction and asterisk', ->
    {tokens} = grammar.tokenizeLine('/directory/*/')
    expect(tokens).toHaveLength 5
    expect(tokens[0]).toEqual value: '/', scopes: ['text.ignore', 'line.directory.ignore', 'constant.restriced.directory.ignore']
    expect(tokens[1]).toEqual value: 'directory', scopes: ['text.ignore', 'line.directory.ignore', 'string.directory.content.ignore']
    expect(tokens[2]).toEqual value: '/', scopes: ['text.ignore', 'line.directory.ignore', 'string.directory.content.ignore', 'constant.separator.directory.ignore']
    expect(tokens[3]).toEqual value: '*', scopes: ['text.ignore', 'line.directory.ignore', 'string.directory.content.ignore', 'constant.other.symbol.asterisk.ignore']
    expect(tokens[4]).toEqual value: '/', scopes: ['text.ignore', 'line.directory.ignore', 'constant.character.directory.ignore']

  it 'contains a description with sub-directory and restiction and asterisks', ->
    {tokens} = grammar.tokenizeLine('/directory1/**/directory2/')
    expect(tokens).toHaveLength 8
    expect(tokens[0]).toEqual value: '/', scopes: ['text.ignore', 'line.directory.ignore', 'constant.restriced.directory.ignore']
    expect(tokens[1]).toEqual value: 'directory1', scopes: ['text.ignore', 'line.directory.ignore', 'string.directory.content.ignore']
    expect(tokens[2]).toEqual value: '/', scopes: ['text.ignore', 'line.directory.ignore', 'string.directory.content.ignore', 'constant.separator.directory.ignore']
    expect(tokens[3]).toEqual value: '*', scopes: ['text.ignore', 'line.directory.ignore', 'string.directory.content.ignore', 'constant.other.symbol.asterisk.ignore']
    expect(tokens[4]).toEqual value: '*', scopes: ['text.ignore', 'line.directory.ignore', 'string.directory.content.ignore', 'constant.other.symbol.asterisk.ignore']
    expect(tokens[5]).toEqual value: '/', scopes: ['text.ignore', 'line.directory.ignore', 'string.directory.content.ignore', 'constant.separator.directory.ignore']
    expect(tokens[6]).toEqual value: 'directory2', scopes: ['text.ignore', 'line.directory.ignore', 'string.directory.content.ignore']
    expect(tokens[7]).toEqual value: '/', scopes: ['text.ignore', 'line.directory.ignore', 'constant.character.directory.ignore']

  it 'contains a description with sub-directory and restiction and range', ->
    {tokens} = grammar.tokenizeLine('/directory1/[a-z]/directory2/')
    expect(tokens).toHaveLength 9
    expect(tokens[0]).toEqual value: '/', scopes: ['text.ignore', 'line.directory.ignore', 'constant.restriced.directory.ignore']
    expect(tokens[1]).toEqual value: 'directory1', scopes: ['text.ignore', 'line.directory.ignore', 'string.directory.content.ignore']
    expect(tokens[2]).toEqual value: '/', scopes: ['text.ignore', 'line.directory.ignore', 'string.directory.content.ignore', 'constant.separator.directory.ignore']
    expect(tokens[3]).toEqual value: '[', scopes: ['text.ignore', 'line.directory.ignore', 'string.directory.content.ignore', 'range.ignore', 'constant.other.symbol.range.begin.ignore']
    expect(tokens[4]).toEqual value: 'a-z', scopes: ['text.ignore', 'line.directory.ignore', 'string.directory.content.ignore', 'range.ignore', 'constant.other.symbol.range.content.ignore']
    expect(tokens[5]).toEqual value: ']', scopes: ['text.ignore', 'line.directory.ignore', 'string.directory.content.ignore', 'range.ignore', 'constant.other.symbol.range.end.ignore']
    expect(tokens[6]).toEqual value: '/', scopes: ['text.ignore', 'line.directory.ignore', 'string.directory.content.ignore', 'constant.separator.directory.ignore']
    expect(tokens[7]).toEqual value: 'directory2', scopes: ['text.ignore', 'line.directory.ignore', 'string.directory.content.ignore']
    expect(tokens[8]).toEqual value: '/', scopes: ['text.ignore', 'line.directory.ignore', 'constant.character.directory.ignore']
