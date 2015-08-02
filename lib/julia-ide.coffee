JuliaIdeView = require './julia-ide-view'
{CompositeDisposable} = require 'atom'

module.exports = JuliaIde =
  juliaIdeView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @juliaIdeView = new JuliaIdeView(state.juliaIdeViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @juliaIdeView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'julia-ide:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @juliaIdeView.destroy()

  serialize: ->
    juliaIdeViewState: @juliaIdeView.serialize()

  toggle: ->
    console.log 'JuliaIde was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
