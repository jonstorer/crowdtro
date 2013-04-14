module.exports =
  callback: (req, res) ->
    req.session.user_id = req.user.id
    res.redirect('/')
