describe 'Ignore grammars', ->

  beforeEach ->
    waitsForPromise ->
      atom.packages.activatePackage 'language-ignore'

  it 'load the "ignore" config grammar', ->
    grammar = atom.grammars.grammarForScopeName 'text.ignore'
    expect(grammar).toBeTruthy()
    expect(grammar.scopeName).toBe 'text.ignore'
