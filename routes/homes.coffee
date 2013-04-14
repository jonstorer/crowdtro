path = require('path')

module.exports =
  show: (req, res) ->
    res.status(200).sendfile path.join __dirname, '..', 'public', 'index.html'

  login: (req, res) ->
    errorMessage = req.flash 'error'
    if req.isAuthenticated()
      req.session = null
      req.logout()
    res.render 'login', { message: errorMessage }

  logout: (req, res) ->
    res.redirect('/login')
