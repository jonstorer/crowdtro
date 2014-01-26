path = require('path')

module.exports =
  show: (req, res) ->
    res.status(200).sendfile path.join __dirname, '..', 'public', 'index.html'

  login: (req, res) ->
    res.render 'login', { message: req.flash 'error' }

  logout: (req, res) ->
    req.logout()
    delete req.session.company
    res.redirect('/login')

  old: (req, res) ->
    res.render 'old', { companyId: req.session.company.id }
